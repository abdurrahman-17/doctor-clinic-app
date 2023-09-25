import 'dart:developer';
import 'package:doctor_clinic_token_app/View/Dashboard/new_dashboard_screen.dart';
import 'package:doctor_clinic_token_app/core/request_response/otpVerify/OtpVerifyResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerifyNotifier extends BaseChangeNotifier {
  OtpVerifyResponse? otpVerifyResponse;

  OtpVerifyNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> doctorOtpVerify(String email, String otp) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.OtpVerify;
    print(url);
    final input = {'email': email, 'otp': otp};
    print(input);
    final response = await http.post(
      Uri.parse(url),
      body: (input),
      headers: {
        //  'Authorization': 'Bearer ${prefs.getToken()}',
        'Accept': 'application/json'
      },
    );
    super.isLoading = false;
    log(response.body);
    final otpVerifyResponse = otpVerifyResponseFromJson(response.body);
    if (response != null && response.statusCode == 200) {
      try {
        final otpVerifyResponse = otpVerifyResponseFromJson(response.body);
        if (otpVerifyResponse.status == true) {
          appShowToast(otpVerifyResponse.message!);
          Get.toNamed(RoutePaths.CHANGENEWPASSWORD, arguments: true);
        } else {
          appShowToast(otpVerifyResponse.message!);
        }
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    } else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    }else {
      appShowToast(otpVerifyResponse.message!);
    }
  }
}
