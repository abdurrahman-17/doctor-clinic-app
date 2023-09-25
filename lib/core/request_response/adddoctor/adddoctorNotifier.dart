import 'dart:convert';
import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/addPatientInfo/addpatientinfoResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/adddoctor/adddoctorResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddDoctorNotifier extends BaseChangeNotifier {
  AddDoctorResponse? addDoctorResponse;

  AddDoctorNotifier() {}

  Future<void> addDoctorInfo(
    int doctorId,
    String fullName,
    String email,
    String password,
    int mobileNumber,
    String gender,
    String licenseNo,
    String imageFilePath,
    String imageName,
    String education,
    String specialization,
    String address,
    String about,
    int experience,
    int patientAttend,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.AddDoctor;
    print(url);
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    request.fields['doctor_id'] = doctorId.toString();
    request.fields['name'] = fullName.toString();
    request.fields['email'] = email.toString();
    request.fields['password'] = password.toString();
    request.fields['patient_attend'] = patientAttend.toString();
    imageName.isEmpty
        ? null
        : request.files.add(await http.MultipartFile.fromPath(
            'image', imageFilePath,
            filename: imageName));
    request.fields['about'] = about.toString();
    request.fields['gender'] = gender.toString();
    request.fields['licence_no'] = licenseNo.toString();
    request.fields['experience'] = experience.toString();
    request.fields['degree'] = education.toString();
    request.fields['phone'] = mobileNumber.toString();
    request.fields['clinic_address'] = address.toString();
    request.fields['specialist'] = specialization.toString();

    request.headers
        .addAll({'Authorization': 'Bearer ${prefs.getString('doctorToken')}'});
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);

    //   Uri.parse(url),
    //   body: (input),
    //   headers: {
    //     'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
    //     'Accept': 'application/json'
    //   },
    // );
    super.isLoading = false;
    print('Hello abdur');
    print(responsed.body);
    print('hjabsduf');
    log(responsed.body);
    final addDoctorInfoResponse = addDoctorResponseFromJson(responsed.body);

    if (responsed.statusCode == 200) {
      try {
        if (addDoctorInfoResponse.status == true) {
          Get.back();
          Get.offAndToNamed(RoutePaths.DoctorList, arguments: true);
          appShowToast(addDoctorInfoResponse.message!);
        } else
          appShowToast(addDoctorInfoResponse.message!);
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    } else if (responsed.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    } else {
      appShowToast(addDoctorInfoResponse.message!);
    }
  }
}
