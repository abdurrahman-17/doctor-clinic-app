import 'dart:developer';
import 'package:doctor_clinic_token_app/View/ManageMedicines/ManageBrand/manageBrand.dart';
import 'package:doctor_clinic_token_app/View/ManageMedicines/MedicineList/medicineList.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'editBrandNameResponse.dart';

class EditBrandNameNotifier extends BaseChangeNotifier {
  Future<void> editBrandName(
    int id,
    String brandName,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;

    String url = DataConstants.LIVE_BASE_URL + DataConstants.EditBrandName;
    final input = {
      'brand_id': id.toString(),
      'medicine_brand_name': brandName,
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
    final addPatientInfoResponse = editBrandNameResponseFromJson(response.body);
    if (response != null && response.statusCode == 200) {
      try {
        if (addPatientInfoResponse.status == true) {
          Get.back();
          Get.to(() => ManageBrand());
        } else
          appShowToast(addPatientInfoResponse.message!);
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    } else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    } else {
      appShowToast(addPatientInfoResponse.message!);
    }
  }
}
