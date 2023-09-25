import 'dart:developer';
import 'package:doctor_clinic_token_app/core/request_response/changenewpassword/changepasswordResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordNotifier extends BaseChangeNotifier {
  ChangePasswordResponse? changePasswordResponse;

  ChangePasswordNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> doctorChangePassword(
      String email, String password, String confirmPassword) async {
    final prefs = await SharedPreferences.getInstance();

    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.ChangePassword;
    print(url);
    final input = {
      'email': email,
      'password': password,
      'cfm_password': confirmPassword,
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

    if (response != null && response.statusCode == 200) {
      try {
        final doctorChangepasswordResponse =
            changePasswordResponseFromJson(response.body);
        if (doctorChangepasswordResponse.status == true) {
          appShowToast(doctorChangepasswordResponse.message!);
          Get.offAllNamed(RoutePaths.LOGIN, arguments: true);
        } else {
          appShowToast(doctorChangepasswordResponse.message!);
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
