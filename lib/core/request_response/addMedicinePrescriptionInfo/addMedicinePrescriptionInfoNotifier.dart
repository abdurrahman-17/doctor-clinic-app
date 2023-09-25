import 'dart:developer';

import 'package:doctor_clinic_token_app/View/ManagePrescription/addPrescription/addPrescription.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/addMedicinePrescriptionInfo/addMedicinePrescriptionInfoResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddMedicinePrescriptionInfoNotifier extends BaseChangeNotifier {
  AddMedicinePrescriptionInfoResponse addMedicinePrescriptionInfoResponse =
      AddMedicinePrescriptionInfoResponse();

  Future<void> addMedicinePrescriptionInfo(
    int doctorId,
    int patientId,
    String drugName,
    String drugFrequency,
    String drugQuantity,
    String drugTiming,
    String medicineComment,
    BuildContext context,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url =
        DataConstants.LIVE_BASE_URL + DataConstants.AddMedicnePrescriptionInfo;
    final input = {
      'doctor_id': doctorId.toString(),
      'appoinment_id': patientId.toString(),
      'medicine_name': drugName.toString(),
      'medicine_quantity': drugQuantity.toString(),
      'medicine_frequency': drugFrequency.toString(),
      'medicine_timing': drugTiming.toString(),
    };
    final input2 = {
      'doctor_id': doctorId.toString(),
      'appoinment_id': patientId.toString(),
      'medicine_name': drugName.toString(),
      'medicine_quantity': drugQuantity.toString(),
      'medicine_frequency': drugFrequency.toString(),
      'medicine_timing': drugTiming.toString(),
      'medicine_comment': medicineComment.toString(),
    };
    final response = await http.post(
      Uri.parse(url),
      body: medicineComment == 'null' ? (input) : (input2),
      headers: {
        'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
        'Accept': 'application/json'
      },
    );
    super.isLoading = false;
    log(response.body);
    final addMedicineResponse =
        addMedicinePrescriptionInfoResponseFromJson(response.body);
    if (response.statusCode == 200) {
      try {
        if (addMedicineResponse.status == true) {
          Navigator.pop(context, true);
          appShowToast(addMedicineResponse.message.toString());
        } else {
          appShowToast(addMedicineResponse.message!);
        }
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    } else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    } else {
      appShowToast(addMedicineResponse.message!);
    }
  }
}
