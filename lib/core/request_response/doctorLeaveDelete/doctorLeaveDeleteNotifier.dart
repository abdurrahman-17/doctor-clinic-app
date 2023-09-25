import 'dart:developer';
import 'package:doctor_clinic_token_app/View/Dashboard/new_dashboard_screen.dart';
import 'package:doctor_clinic_token_app/View/Out%20Of%20Office/outofoffice.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorLeaveDelete/doctorLeaveDeleteResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/otpVerify/OtpVerifyResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorLeaveDeleteNotifier extends BaseChangeNotifier {
  DoctorLeaveDeleteResponse? doctorLeaveDeleteResponse;

  DoctorLeaveDeleteNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> doctorLeaveDelete(int id) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.DoctorLeaveDelete;
    print(url);
    final input = {'id': id.toString()};
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

    if (response != null && response.statusCode == 200) {
      try {
        final doctorLeaveResponse = doctorLeaveDeleteResponseFromJson(response.body);
        if (doctorLeaveResponse.status == true) {
          Get.back();
          Get.offAndToNamed(RoutePaths.OutOfOffice);
        } else {
          appShowToast(doctorLeaveResponse.message!);
        }
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    } else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    }
  }
}
