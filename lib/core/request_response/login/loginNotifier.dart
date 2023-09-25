import 'dart:developer';

import 'package:doctor_clinic_token_app/View/Dashboard/new_dashboard_screen.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/login/loginresponse.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends BaseChangeNotifier {
  LoginResponse? loginResponse;

  LoginNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> doctorLogin(
    String email,
    String password,
    String deviceType,
    String deviceToken,
  ) async {
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Login;
    print(url);
    final input = {
      'email': email,
      'password': password,
      'device_type': deviceType,
      'device_token': deviceToken,
    };
    print(input);
    print('sulaiman');
    final response = await http.post(
      Uri.parse(url),
      body: (input),
      headers: {'Accept': 'application/json'},
    );
    super.isLoading = false;
    log(response.body);
    final doctorLoginResponse = loginResponseFromJson(response.body);

    if (response.statusCode == 200) {
      final doctorLoginResponse = loginResponseFromJson(response.body);
      try {
        if (doctorLoginResponse.status == true) {
          final prefs = await SharedPreferences.getInstance();
          prefs.setString(
              "doctorToken", doctorLoginResponse.data!.apiToken.toString());
          MySharedPreferences.instance.setDoctorScheduleType(
              'doctorScheduleType', doctorLoginResponse.data!.type ?? 0);
          MySharedPreferences.instance
              .setDoctorId('doctorID', doctorLoginResponse.data!.id ?? 0);
          MySharedPreferences.instance.setDoctorEmail(
              'doctorEmail', doctorLoginResponse.data!.email.toString());
          MySharedPreferences.instance.setDoctorName(
              'doctorName', doctorLoginResponse.data!.name.toString());
          MySharedPreferences.instance.setDoctorAbout(
              'doctorAbout', doctorLoginResponse.data!.about.toString());
          MySharedPreferences.instance.setDoctorExperience(
              'doctorExperience', doctorLoginResponse.data!.experience ?? 0);
          MySharedPreferences.instance.setDoctorSpecialist('doctorSpecialist',
              doctorLoginResponse.data!.specialist.toString());
          MySharedPreferences.instance.setDoctorPatientAttend(
              'doctorPatientAttend',
              doctorLoginResponse.data!.patientAttend ?? 0);
          MySharedPreferences.instance.setDoctorPhone(
              'doctorPhone', doctorLoginResponse.data!.phone.toString());
          MySharedPreferences.instance.setGender(
              'doctorGender', doctorLoginResponse.data!.gender.toString());
          MySharedPreferences.instance.setEducation(
              'doctorEducation', doctorLoginResponse.data!.degree.toString());
          MySharedPreferences.instance.setAddress(
              'doctorAddress', doctorLoginResponse.data!.address.toString());
          MySharedPreferences.instance.setImage(
              'doctorImage', doctorLoginResponse.data!.image.toString());
          MySharedPreferences.instance.setLicenseNo(
              'doctorLicenseNo', doctorLoginResponse.data!.license.toString());
          MySharedPreferences.instance
              .setRole('doctorRole', doctorLoginResponse.data!.role ?? 0);
          appShowToast(doctorLoginResponse.message.toString());
          MySharedPreferences.instance.setPrescriptionStatus(
              'doctorPrescriptionStatus',
              doctorLoginResponse.data!.prescriptionDoctorStatus ?? 0);
          MySharedPreferences.instance.setDoctorClinicParentId(
              'doctorParentId', doctorLoginResponse.data!.parentId ?? 0);
          appShowToast(doctorLoginResponse.message.toString());
          Get.off(DashboardScreens(), arguments: true);
        } else {
          appShowToast(doctorLoginResponse.message.toString());
        }
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    } else {
      appShowToast(doctorLoginResponse.message.toString());
    }
  }
}
