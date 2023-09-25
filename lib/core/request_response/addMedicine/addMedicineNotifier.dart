import 'dart:developer';
import 'package:doctor_clinic_token_app/View/ManageMedicines/MedicineList/medicineList.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'addMedicineResponse.dart';

class AddMedicineNotifier extends BaseChangeNotifier {
  AddMedicineResponse? addMedicineResponse;

  AddMedicineNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> addMedicine(
    int doctorId,
    String drugName,
    String brandName,
    int categoryId,
    String contentMeasurement,
    int dosage,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;

    String url = DataConstants.LIVE_BASE_URL + DataConstants.AddMedicine;
    final input;
    if (contentMeasurement == '' && dosage == 0 && brandName == '') {
      input = {
        'doctor_id': doctorId.toString(),
        'drug_name': drugName,
        'category_id': categoryId.toString(),
      };
    } else if (contentMeasurement == '' && dosage == 0) {
      input = {
        'doctor_id': doctorId.toString(),
        'brand_id': brandName,
        'drug_name': drugName,
        'category_id': categoryId.toString(),
      };
    } else if (contentMeasurement == '' && brandName == '') {
      input = {
        'doctor_id': doctorId.toString(),
        'drug_name': drugName,
        'category_id': categoryId.toString(),
        'dosage': dosage.toString(),
      };
    } else if (dosage == 0 && brandName == '') {
      input = {
        'doctor_id': doctorId.toString(),
        'drug_name': drugName,
        'category_id': categoryId.toString(),
        'content_measurement': contentMeasurement,
      };
    } else if (dosage == 0) {
      input = {
        'doctor_id': doctorId.toString(),
        'brand_id': brandName,
        'drug_name': drugName,
        'category_id': categoryId.toString(),
        'content_measurement': contentMeasurement,
      };
    } else if (brandName == '') {
      input = {
        'doctor_id': doctorId.toString(),
        'drug_name': drugName,
        'category_id': categoryId.toString(),
        'content_measurement': contentMeasurement,
        'dosage': dosage.toString(),
      };
    } else if (contentMeasurement == '') {
      input = {
        'doctor_id': doctorId.toString(),
        'brand_id': brandName,
        'drug_name': drugName,
        'category_id': categoryId.toString(),
        'dosage': dosage.toString(),
      };
    } else {
      input = {
        'doctor_id': doctorId.toString(),
        'brand_id': brandName,
        'drug_name': drugName,
        'category_id': categoryId.toString(),
        'content_measurement': contentMeasurement,
        'dosage': dosage.toString(),
      };
    }
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
    final addPatientInfoResponse = addMedicineResponseFromJson(response.body);
    if (response != null && response.statusCode == 200) {
      try {
        if (addPatientInfoResponse.status == true) {
          Get.back();
          Get.back();
          Get.to(() => MedicineList());
        } else
          appShowToast(addPatientInfoResponse.message!);
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    } else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    } else {
      appShowToast(addPatientInfoResponse.message!);
    }
  }
}
