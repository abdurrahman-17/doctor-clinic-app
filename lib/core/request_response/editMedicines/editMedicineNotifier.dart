import 'dart:developer';
import 'package:doctor_clinic_token_app/View/ManageMedicines/MedicineList/medicineList.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'editMedicineResponse.dart';

class EditMedicineNotifier extends BaseChangeNotifier {
  EditMedicineResponse? editMedicineResponse;

  EditMedicineNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> editMedicine(
    int medicineId,
    String drugName,
    int categoryId,
    String contentMeasurement,
    int dosage,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;

    String url = DataConstants.LIVE_BASE_URL + DataConstants.EditMedicine;
    final input = {
      'medicine_prescription_id': medicineId.toString(),
      'drug_name': drugName,
      'category_id': categoryId.toString(),
      'content_measurement': contentMeasurement,
      'dosage': dosage.toString(),
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
    final addPatientInfoResponse = editMedicineResponseFromJson(response.body);
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
