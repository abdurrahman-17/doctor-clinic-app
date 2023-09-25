import 'dart:developer';
import 'package:doctor_clinic_token_app/View/ManageMedicines/ManageCategory/manageCategory.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'addCategoryResponse.dart';

class AddCategoryNotifier extends BaseChangeNotifier {
  AddCategoryResponse? addCategoryResponse;

  AddCategoryNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> addCategory(
    int doctorId,
    String categoryName,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;

    String url = DataConstants.LIVE_BASE_URL + DataConstants.AddCategory;
    final input = {
      'doctor_id': doctorId.toString(),
      'category_name': categoryName,
    };
    print(input);
    final response = await http.post(
      Uri.parse(url),
      body: (input),
      headers: {
        'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
        'Accept': 'application/json'
      },
    );
    super.isLoading = false;
    log(response.body);
    final addContentMeasurementResponse =
        addCategoryResponseFromJson(response.body);
    if (response != null && response.statusCode == 200) {
      try {
        if (addContentMeasurementResponse.status == true) {
          Get.back();
          Get.to(() => ManageCategory());
          appShowToast(addContentMeasurementResponse.message!);
        } else
          appShowToast(addContentMeasurementResponse.message!);
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    } else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    } else {
      appShowToast(addContentMeasurementResponse.message!);
    }
  }
}
