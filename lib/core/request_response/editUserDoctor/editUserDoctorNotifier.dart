import 'dart:convert';
import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/addPatientInfo/addpatientinfoResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/adddoctor/adddoctorResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/editUserDoctor/editUserDoctorResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/updateDoctorProfile/updateDoctorProfileResponse.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditUserDoctorNotifier extends BaseChangeNotifier {
  EditUserDoctorResponse? editUserDoctorResponse;

  EditUserDoctorNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> editUserDoctorProfileInfo(
    int doctorId,
    String fullName,
    String email,
    String imageFilePath,
    String imageName,
    int mobileNumber,
    String gender,
    String license,
    String education,
    String specialization,
    String address,
    String about,
    int experience,
    int patientAttend,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.EditUserDoctor;
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
    license == '' ? null : request.fields['licence_no'] = license.toString();
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
        final editDoctorResponse =
            editUserDoctorResponseFromJson(responsed.body);
        if (editDoctorResponse.status == true) {
          MySharedPreferences.instance.setDoctorName(
              'doctorName', editDoctorResponse.data!.name.toString());
          MySharedPreferences.instance.setDoctorAbout(
              'doctorAbout', editDoctorResponse.data!.about.toString());
          MySharedPreferences.instance.setDoctorExperience('doctorExperience',
              int.parse(editDoctorResponse.data!.experience.toString()));
          MySharedPreferences.instance.setDoctorSpecialist('doctorSpecialist',
              editDoctorResponse.data!.specialist.toString());
          MySharedPreferences.instance.setDoctorPatientAttend(
              'doctorPatientAttend',
              int.parse(editDoctorResponse.data!.patientAttend.toString()));
          MySharedPreferences.instance.setDoctorPhone(
              'doctorPhone', editDoctorResponse.data!.phone.toString());
          MySharedPreferences.instance.setGender(
              'doctorGender', editDoctorResponse.data!.gender.toString());
          MySharedPreferences.instance.setEducation(
              'doctorEducation', editDoctorResponse.data!.degree.toString());
          MySharedPreferences.instance.setAddress(
              'doctorAddress', editDoctorResponse.data!.address.toString());
          MySharedPreferences.instance.setLicenseNo(
              'doctorLicenseNo', editDoctorResponse.data!.license.toString());
          MySharedPreferences.instance.setImage(
              'doctorImage', editDoctorResponse.data!.image.toString());
          Get.back();
          Get.back();
          appShowToast(editDoctorResponse.message!);
        } else
          appShowToast(editDoctorResponse.message!);
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
