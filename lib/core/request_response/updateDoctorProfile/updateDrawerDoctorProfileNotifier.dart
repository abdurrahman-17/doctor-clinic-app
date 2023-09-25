import 'dart:convert';
import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/addPatientInfo/addpatientinfoResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/adddoctor/adddoctorResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/updateDoctorProfile/updateDoctorProfileResponse.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdateDrawerDoctorProfileNotifier extends BaseChangeNotifier {
  UpdateDoctorProfileResponse? updateDoctorProfileResponse;

  UpdateDrawerDoctorProfileNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> updateDrawerDoctorProfileInfo(
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
        final updateDrawerDoctorResponse =
            updateDoctorProfileResponseFromJson(responsed.body);
        if (updateDrawerDoctorResponse.status == true) {
          MySharedPreferences.instance.setDoctorName(
              'doctorName', updateDrawerDoctorResponse.data!.name.toString());
          MySharedPreferences.instance.setDoctorAbout(
              'doctorAbout', updateDrawerDoctorResponse.data!.about.toString());
          MySharedPreferences.instance.setDoctorExperience(
              'doctorExperience',
              int.parse(
                  updateDrawerDoctorResponse.data!.experience.toString()));
          MySharedPreferences.instance.setDoctorSpecialist('doctorSpecialist',
              updateDrawerDoctorResponse.data!.specialist.toString());
          MySharedPreferences.instance.setDoctorPatientAttend(
              'doctorPatientAttend',
              int.parse(
                  updateDrawerDoctorResponse.data!.patientAttend.toString()));
          MySharedPreferences.instance.setDoctorPhone(
              'doctorPhone', updateDrawerDoctorResponse.data!.phone.toString());
          MySharedPreferences.instance.setGender('doctorGender',
              updateDrawerDoctorResponse.data!.gender.toString());
          MySharedPreferences.instance.setLicenseNo('doctorLicenseNo',
              updateDrawerDoctorResponse.data!.license.toString());
          MySharedPreferences.instance.setEducation('doctorEducation',
              updateDrawerDoctorResponse.data!.degree.toString());
          MySharedPreferences.instance.setAddress('doctorAddress',
              updateDrawerDoctorResponse.data!.address.toString());
          MySharedPreferences.instance.setImage(
              'doctorImage', updateDrawerDoctorResponse.data!.image.toString());
          Get.back();
          Get.back();
          appShowToast(updateDrawerDoctorResponse.message!);
        } else
          appShowToast(updateDrawerDoctorResponse.message!);
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
