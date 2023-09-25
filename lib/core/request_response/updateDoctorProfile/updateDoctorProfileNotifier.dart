import 'dart:convert';
import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/addPatientInfo/addpatientinfoResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/adddoctor/adddoctorResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/updateDoctorProfile/updateDoctorProfileResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateDoctorProfileNotifier extends BaseChangeNotifier {
  UpdateDoctorProfileResponse? updateDoctorProfileResponse;

  UpdateDoctorProfileNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> updateDoctorProfileInfo(
    int doctorId,
    String fullName,
    String email,
    String imageFilePath,
    String imageName,
    int mobileNumber,
    String gender,
    String licenseNo,
    String education,
    String specialization,
    String address,
    String about,
    int experience,
    int patientAttend,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url =
        DataConstants.LIVE_BASE_URL + DataConstants.UpdateDoctorProfile;
    print(url);
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    request.fields['user_id'] = doctorId.toString();
    request.fields['name'] = fullName.toString();
    request.fields['email'] = email.toString();
    request.fields['patient_attend'] = patientAttend.toString();
    imageName.isEmpty
        ? null
        : request.files.add(await http.MultipartFile.fromPath(
            'image', imageFilePath,
            filename: imageName));
    request.fields['about'] = about.toString();
    request.fields['gender'] = gender.toString();
    licenseNo == ''
        ? null
        : request.fields['licence_no'] = licenseNo.toString();
    request.fields['experience'] = experience.toString();
    request.fields['degree'] = education.toString();
    request.fields['phone'] = mobileNumber.toString();
    request.fields['address'] = address.toString();
    request.fields['specialist'] = specialization.toString();
    request.headers
        .addAll({'Authorization': 'Bearer ${prefs.getString('doctorToken')}'});
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
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
        final updateDoctorResponse =
            updateDoctorProfileResponseFromJson(responsed.body);
        if (updateDoctorResponse.status == true) {
          Get.back();
          Get.back();
          Get.toNamed(RoutePaths.DoctorList, arguments: true);
          appShowToast(updateDoctorResponse.message!);
        } else
          appShowToast(updateDoctorResponse.message!);
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
