import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/getMedicineCategory/getMedicineCategoryResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetMedicineCategoryNotifier extends BaseChangeNotifier {
  bool isloading = false;

  //
  // Date termsAndConditions_Date_ResponseClass = Date();
  // Date get TermsAndConditions_Date_Class => termsAndConditions_Date_ResponseClass;
  //
  // set   TermsAndConditions_Date_Class(Date value) {
  //   termsAndConditions_Date_ResponseClass = value;
  //   notifyListeners();
  // }

  List<MedicineCategoryData> getCategoryClass = [];

  List<MedicineCategoryData> get GetCategoryClass => getCategoryClass;

  set GetCategoryClass(List<MedicineCategoryData> value) {
    getCategoryClass = value;
    notifyListeners();
  }

  Future<void> getCategory() async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url =
        DataConstants.LIVE_BASE_URL + DataConstants.GetMedicineCategory;
    print(url);
    try {
      //   final input = {'patient_id': id,'date':date};
      //print(input);
      final response = await http.get(
        Uri.parse(url),
        //body: input,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
          'Accept': 'application/json'
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        final appointmentModel =
            getMedicineCategoryResponseFromJson(response.body);
        GetCategoryClass = appointmentModel.data ?? [];
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
