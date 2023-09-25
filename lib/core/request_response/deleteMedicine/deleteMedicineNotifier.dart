import 'dart:developer';

import 'package:doctor_clinic_token_app/View/ManageMedicines/MedicineList/medicineList.dart';
import 'package:doctor_clinic_token_app/View/Out%20Of%20Office/outofoffice.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'deleteMedicineResponse.dart';

class DeleteMedicineNotifier extends BaseChangeNotifier {
  bool isloading = false;

  Future<void> deleteMedicine(
    int id,
    int medicineId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.DeleteMedicine;
    print(url);
    try {
      final input = {
        'doctor_id': id.toString(),
        'medicine_prescription_id': medicineId.toString(),
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
      final voucherTypeModel = deleteMedicineResponseFromJson(response.body);
      if (response.statusCode == 200) {
        appShowToast(voucherTypeModel.message.toString());
        notifyListeners();
        Get.back();
        Get.back();
        Get.to(() => MedicineList());
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
