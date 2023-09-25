import 'dart:developer';

import 'package:doctor_clinic_token_app/View/login/login.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/registration/registrationResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterNotifier extends BaseChangeNotifier {
  RigistrationResponse? rigistrationResponse;

  RegisterNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> doctorRegister(
    String email,
    String password,
    String name,
    String address,
    String city,
    String state,
    int zipCode,
    String about,
    int experience,
    String specialist,
    String degree,
    int phone,
    String clinicAddress,
    int scheduleType,
  ) async {
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Register;
    print(url);
    final input = {
      'email': email.toString(),
      'password': password.toString(),
      'name': name.toString(),
      'house_address': address.toString(),
      'city': city.toString(),
      'state': state.toString(),
      'zip_code': zipCode.toString(),
      'about': about.toString(),
      'experience': experience.toString(),
      'specialist': specialist.toString(),
      'degree': degree.toString(),
      'phone': phone.toString(),
      'clinic_address': clinicAddress.toString(),
      'schedule_type': scheduleType.toString(),
    };
    print(input);
    final response = await http.post(
      Uri.parse(url),
      body: (input),
      headers: {'Accept': 'application/json'},
    );
    super.isLoading = false;
    log(response.body);
    final doctorRegisterResponse = rigistrationResponseFromJson(response.body);

    if (response.statusCode == 200) {
      final doctorRegisterResponse =
          rigistrationResponseFromJson(response.body);
      try {
        if (doctorRegisterResponse.status == true) {
          final prefs = await SharedPreferences.getInstance();
          // prefs.setString("doctorToken", doctorRegisterResponse.data!.apiToken!);
          // MySharedPreferences.instance.setDoctorScheduleType('doctorScheduleType', doctorLoginResponse.data!.type!);
          // MySharedPreferences.instance.setDoctorId('doctorID', doctorRegisterResponse.data!.id!);
          // MySharedPreferences.instance.setDoctorName('doctorName', doctorRegisterResponse.data!.name!);
          // MySharedPreferences.instance.setDoctorAbout('doctorAbout', doctorRegisterResponse.data!.about!);
          // MySharedPreferences.instance.setDoctorExperience('doctorExperience', doctorRegisterResponse.data!.experience!);
          // MySharedPreferences.instance.setDoctorSpecialist('doctorSpecialist', doctorRegisterResponse.data!.specialist!);
          // MySharedPreferences.instance.setDoctorPatientAttend('doctorPatientAttend', doctorRegisterResponse.data!.patientAttend!);
          // MySharedPreferences.instance.setDoctorPhone('doctorPhone', doctorLoginResponse.data!.phone!);
          appShowToast(doctorRegisterResponse.message!);
          Get.off(Login(), arguments: true);
        } else {
          appShowToast(doctorRegisterResponse.message!);
        }
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    } else {
      appShowToast(doctorRegisterResponse.message!);
    }
  }
}
