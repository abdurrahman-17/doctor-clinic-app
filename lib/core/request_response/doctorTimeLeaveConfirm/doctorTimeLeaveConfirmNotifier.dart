import 'dart:developer';

import 'package:doctor_clinic_token_app/View/Out%20Of%20Office/outofoffice.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'doctorTimeLeaveConfirmResponse.dart';

class DoctorTimeLeaveConfirmNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;

  Future<void> doctorTimeLeaveConfirm(
    int id,
    String fromDate,
    String toDate,
    String fromTime,
    String toTime,
    String reason,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url =
        DataConstants.LIVE_BASE_URL + DataConstants.DoctorTimeLeaveConfirm;
    print(url);
    try {
      final input = {
        'doctor_id': id.toString(),
        'from_date': fromDate,
        'to_date': toDate,
        'from_time': fromTime,
        'to_time': toTime,
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
          doctorTimeLeaveConfirmResponseFromJson(response.body);
      appShowToast(voucherTypeModel.message.toString());
      if (response.statusCode == 200) {
        //Get.off(OutOfOffice());
        Get.back();
        Get.back();
        Get.back();
        Get.to(OutOfOffice());
        notifyListeners();
      } else if (response.statusCode == 401) {
        print('You are unauthorized, please login again');
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
