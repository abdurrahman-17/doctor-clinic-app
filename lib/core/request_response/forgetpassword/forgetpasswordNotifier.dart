import 'dart:developer';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgetpasswordResponse.dart';

class ForgetPasswordNotifier extends BaseChangeNotifier {
  ForgetPasswordResponse? forgetPasswordResponse;

  ForgetPasswordNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> doctorForgetPassword(String email) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.ForgetPassword;
    print(url);
    final input = {'email': email};
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

    final doctorForgetResponse =
    forgetPasswordResponseFromJson(response.body);

    if (response != null && response.statusCode == 200) {
      try {
        final doctorForgetResponse =
            forgetPasswordResponseFromJson(response.body);
        if (doctorForgetResponse.status == true) {
          appShowToast(doctorForgetResponse.message!);
          Get.toNamed(RoutePaths.OTPVERIFICATION, arguments: true);
        } else {
          appShowToast(doctorForgetResponse.message!);
        }
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    } else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    }else{
      appShowToast(doctorForgetResponse.message!);
    }
  }
}
