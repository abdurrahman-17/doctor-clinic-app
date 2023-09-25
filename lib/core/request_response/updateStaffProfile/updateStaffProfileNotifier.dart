import 'dart:convert';
import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';

import 'package:doctor_clinic_token_app/core/request_response/updateDoctorProfile/updateDoctorProfileResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/updateStaffProfile/updateStaffProfileResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateStaffProfileNotifier extends BaseChangeNotifier {
  UpdateStaffProfileResponse? updateStaffProfileResponse;

  UpdateStaffProfileNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> updateStaffProfileInfo(
      int id,
      String fullName,
      String email,
      String imageFilePath,
      String imageName,
      int mobileNumber,
      String address,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.UpdateStaffProfile;
    print(url);
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    request.fields['user_id'] = id.toString();
    request.fields['name'] = fullName.toString();
    request.fields['email'] = email.toString();
    imageName.isEmpty ? null :request.files.add(await http.MultipartFile.fromPath('image', imageFilePath,
        filename: imageName));
    request.fields['phone'] = mobileNumber.toString();
    request.fields['address'] = address;
    request.headers.addAll({'Authorization': 'Bearer ${prefs.getString('doctorToken')}'});
    var response=await request.send();
    var responsed=await http.Response.fromStream(response);
    // final input = {
    //   'doctor_id': doctorId.toString(),
    //   'name': fullName.toString(),
    //   'email': email.toString(),
    //   'password': password.toString(),
    //   'patient_attend': patientAttend.toString(),
    //   'image': imageFile.toString(),
    //   'about': about.toString(),
    //   'gender': gender.toString(),
    //   'experience': experience.toString(),
    //   'degree': education.toString(),
    //   'phone': mobileNumber.toString(),
    //   'clinic_address': address.toString(),
    //   'specialist': specialization.toString(),
    // };
    // print(input);
    // final response = await http.post(
    //   Uri.parse(url),
    //   body: (input),
    //   headers: {
    //     'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
    //     'Accept': 'application/json'
    //   },
    // );
    super.isLoading = false;
    print('Hello abdur');
    print(responsed);
    print('hjabsduf');
    log(responsed.body);

    if (responsed.statusCode == 200) {
      try {
        final updateStaffResponse = updateStaffProfileResponseFromJson(responsed.body);
        if (updateStaffResponse.status == true) {
          Get.back();
          Get.back();
          Get.toNamed(RoutePaths.StaffList, arguments: true);
          appShowToast(updateStaffResponse.message!);
        } else
          appShowToast(updateStaffResponse.message!);
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
