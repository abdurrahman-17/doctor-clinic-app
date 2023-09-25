import 'dart:developer';

import 'package:doctor_clinic_token_app/View/ListOfAppointment/listOfAppointment.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/addPatientInfo/addpatientinfoResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/addWalkinPatient/addWalkinPatientResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddWalkinNotifier extends BaseChangeNotifier {
  AddWalkinPatientResponse addWalkinPatientResponse =
      AddWalkinPatientResponse();

  AddWalkinNotifier() {}

  Future<void> addWalkInInfo(
    int doctorId,
    String date,
    String day,
    String session,
    String healthIssue,
    String appointmentTime,
    String tokenNo,
    String patientName,
    int scheduleType,
    String dateofbirth,
    String gender,
    int mobileNumber,
    int height,
    int weight,
    int pulseRate,
    int spo2,
    int temperature,
    int bloodPressure,
    int diabetes,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.AddWalkInInfo;
    print(url);
    print('Praveen and Siva');
    print(doctorId);
    final input = {
      'doctor_id': doctorId.toString(),
      'date': date.toString(),
      'day': day.toString(),
      'session': session.toString(),
      'appointment_time': appointmentTime.toString(),
      'description': healthIssue.toString(),
      'full_name': patientName.toString(),
      'type': scheduleType.toString(),
      'dateofbirth': dateofbirth.toString(),
      'gender': gender.toString(),
      'phone': mobileNumber.toString(),
      'height': height.toString(),
      'weight': weight.toString(),
      'pulse_rate': pulseRate.toString(),
      'spo2': spo2.toString(),
      'temperature': temperature.toString(),
      'blood_pressure': bloodPressure.toString(),
      'diabetes': diabetes.toString(),
    };
    final input2 = {
      'doctor_id': doctorId.toString(),
      'date': date.toString(),
      'day': day.toString(),
      'session': session.toString(),
      //'appointment_time': appointmentTime.toString(),
      'token_no': tokenNo,
      //'age': '21',
      'description': healthIssue.toString(),
      'full_name': patientName.toString(),
      'type': scheduleType.toString(),
      'dateofbirth': dateofbirth.toString(),
      'gender': gender.toString(),
      'phone': mobileNumber.toString(),
      'height': height.toString(),
      'weight': weight.toString(),
      'pulse_rate': pulseRate.toString(),
      'spo2': spo2.toString(),
      'temperature': temperature.toString(),
      'blood_pressure': bloodPressure.toString(),
      'diabetes': diabetes.toString(),
    };
    final input3 = {
      'doctor_id': doctorId.toString(),
      'date': date.toString(),
      'day': day.toString(),
      'session': session.toString(),
      //'appointment_time': appointmentTime.toString(),
      //'token_no': '2',
      //'age': '21',
      'description': healthIssue.toString(),
      'full_name': patientName.toString(),
      'type': scheduleType.toString(),
      'dateofbirth': dateofbirth.toString(),
      'gender': gender.toString(),
      'phone': mobileNumber.toString(),
      'height': height.toString(),
      'weight': weight.toString(),
      'pulse_rate': pulseRate.toString(),
      'spo2': spo2.toString(),
      'temperature': temperature.toString(),
      'blood_pressure': bloodPressure.toString(),
      'diabetes': diabetes.toString(),
    };
    print(scheduleType == 1
        ? input
        : scheduleType == 2
            ? input2
            : input3);
    final response = await http.post(
      Uri.parse(url),
      body: scheduleType == 1
          ? (input)
          : scheduleType == 2
              ? (input2)
              : (input3),
      headers: {
        'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
        'Accept': 'application/json'
      },
    );
    super.isLoading = false;
    log(response.body);
    log(response.statusCode.toString());
    final addWalkInResponse = addWalkinPatientResponseFromJson(response.body);
    if (response.statusCode == 200) {
      try {
        final addWalkInResponse =
            addWalkinPatientResponseFromJson(response.body);
        if (addWalkInResponse.status == true) {
          appShowToast(addWalkInResponse.message!);
          Get.back();
          Get.to(ListOfAppointment(selectedPage: 1));
        } else
          appShowToast(addWalkInResponse.message!);
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    } else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    } else {
      appShowToast(addWalkInResponse.message!);
    }
  }
}
