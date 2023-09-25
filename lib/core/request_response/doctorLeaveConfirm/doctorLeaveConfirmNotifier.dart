import 'dart:convert';
import 'dart:developer';

import 'package:doctor_clinic_token_app/View/Out%20Of%20Office/outofoffice.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorLeaveConfirm/doctorLeaveConfirmResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DoctorLeaveConfirmNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;

  Future<void> doctorLeaveConfirm(
    int id,
    String fromDate,
    String toDate,
    String reason,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.DoctorLeaveConfirm;
    print(url);
    try {
      final input = {
        'doctor_id': id.toString(),
        'from_date': fromDate,
        'to_date': toDate,
        'reason': reason,
      };
      print(input);
      final response = await http.post(
        Uri.parse(url),
        body: input,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
          'Accept': 'application/json'
        },
      );
      log(response.body);
      final voucherTypeModel =
          doctorLeaveConfirmResponseFromJson(response.body);
      if (response.statusCode == 200) {
        appShowToast(voucherTypeModel.message.toString());
        notifyListeners();
        Get.back();
        Get.back();
        Get.back();
        // Get.off(OutOfOffice());
        Get.to(OutOfOffice());
      } else if (response.statusCode == 401) {
        print('You are unauthorized, please login again');
        //Get.offAllNamed(RoutePaths.LOGIN);
      } else {
        print('error123');
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
