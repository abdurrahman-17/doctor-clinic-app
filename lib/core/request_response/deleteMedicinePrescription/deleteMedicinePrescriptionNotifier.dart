import 'dart:developer';

import 'package:doctor_clinic_token_app/View/ManageMedicines/MedicineList/medicineList.dart';
import 'package:doctor_clinic_token_app/View/ManagePrescription/addPrescription/addPrescription.dart';
import 'package:doctor_clinic_token_app/View/Out%20Of%20Office/outofoffice.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'deleteMedicinePrescriptionResponse.dart';

class DeleteMedicinePrescriptionNotifier extends BaseChangeNotifier {
  bool isloading = false;

  Future<void> deleteMedicinePrescription(
    String medicineId,
    int patientid,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url =
        DataConstants.LIVE_BASE_URL + DataConstants.DeleteMedicinePrescription;
    print(url);
    try {
      final input = {
        'prescription_info_id': medicineId.toString(),
      };
      print(input);
      final response = await http.post(
        Uri.parse(url),
        body: input,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
          'Accept': 'application/json'
        },
      );
      log(response.body);
      final voucherTypeModel =
          deleteMedicinePrescriptionResponseFromJson(response.body);
      if (response.statusCode == 200) {
        appShowToast(voucherTypeModel.message.toString());
        notifyListeners();
        // Get.back();
        // Get.to(() => AddPrescription(
        //       patientId: patientid,
        //     ));
      } else if (response.statusCode == 401) {
        print('You are unauthorized, please login again');
      } else {
        print('error123');
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
