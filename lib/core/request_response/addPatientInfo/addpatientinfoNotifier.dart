import 'dart:developer';

import 'package:doctor_clinic_token_app/View/ListOfAppointment/listOfAppointment.dart';
import 'package:doctor_clinic_token_app/View/Patient%20Data/appointment.dart';
import 'package:doctor_clinic_token_app/View/Patient%20Data/patient_data.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/addPatientInfo/addpatientinfoResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddPatientInfoNotifier extends BaseChangeNotifier {
  AddPatientInfoResponse? addPatientInfoResponse;

  AddPatientInfoNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> addPatientInfo(
    int Id,
    int bloodPressure,
    int diabetes,
    double temperature,
    int spo2,
    int pulseRate,
    int weight,
    int height,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.AddPatientInfo;
    print(url);
    final input = {
      'appoinment_id': Id.toString(),
      'blood_pressure':
          bloodPressure == 0 ? 0.toString() : bloodPressure.toString(),
      'diabetes': diabetes == 0 ? 0.toString() : diabetes.toString(),
      'temperature': temperature == 0 ? 0.toString() : temperature.toString(),
      'spo2': spo2 == 0 ? 0.toString() : spo2.toString(),
      'pulse_rate': pulseRate == 0 ? 0.toString() : pulseRate.toString(),
      'weight': weight == 0 ? 0.toString() : weight.toString(),
      'height': height == 0 ? 0.toString() : height.toString(),
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
        final addPatientInfoResponse =
            addPatientInfoResponseFromJson(response.body);
        if (addPatientInfoResponse.status == true) {
          Get.back();
          Get.back();
          Get.to(ListOfAppointment(selectedPage: 1));
        } else
          appShowToast(addPatientInfoResponse.message!);
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
