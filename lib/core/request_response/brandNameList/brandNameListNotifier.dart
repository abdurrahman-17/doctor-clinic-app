import 'dart:developer';

import 'package:doctor_clinic_token_app/View/ManageMedicines/ManageBrand/manageBrand.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'brandNameListResponse.dart';

class BrandNameListNotifier extends BaseChangeNotifier {
  bool isloading = false;

  List<BrandNameData> getBrandNameListClass = [];

  List<BrandNameData> get GetBrandNameListClass => getBrandNameListClass;

  set GetBrandNameListClass(List<BrandNameData> value) {
    getBrandNameListClass = value;
    notifyListeners();
  }

  Future<void> getBrandNameList() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.BrandNameList;
    print(url);
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
          'Accept': 'application/json'
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        final appointmentModel = brandNameListResponseFromJson(response.body);
        GetBrandNameListClass = appointmentModel.data!;

        notifyListeners();
      } else if (response.statusCode == 401) {
        appShowToast('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else {
        print('error');
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
