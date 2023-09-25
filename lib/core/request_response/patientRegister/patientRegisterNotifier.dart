import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/patientRegister/patientRegisterResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PatientRegisterNotifier extends BaseChangeNotifier {
  RegisterResponse? registerResponse;

  RegisterNotifier() {}

  Future<void> PatientRegister(
    String email,
    String password,
    String name,
    String Dob,
    String address,
    String city,
    String state,
    String zipcode,
    String mobilenumber,
  ) async {
    super.isLoading = true;
    String url = 'https://almuhasabah.colanapps.in/admin/clinic2/public' +
        DataConstants.PatientRegister;
    print(url);
    final input = {
      'name': name,
      'email': email,
      'password': password,
      'dateofbirth': Dob,
      'address': address,
      'city': city,
      'state': state,
      'zip_code': zipcode,
      'mobile_number': mobilenumber,
    };
    print(input);
    final response = await http.post(
      Uri.parse(url),
      body: (input),
      headers: {'Accept': 'application/json'},
    );
    super.isLoading = false;
    log(response.body);
    final patientRegister = registerResponseFromJson(response.body);
    if (response.statusCode == 200) {
      try {
        final patientRegister = registerResponseFromJson(response.body);
        if (patientRegister.status == true) {
          print('check');
          appShowToast(patientRegister.message.toString());
          Get.back();
        } else {
          print('irfan');
          appShowToast(patientRegister.message.toString());
        }
      } catch (e) {
        print('hi');
        print(e);
        appShowToast(e.toString());
      }
    } else {
      print('hello');
      appShowToast(patientRegister.message.toString());
    }
  }
}
