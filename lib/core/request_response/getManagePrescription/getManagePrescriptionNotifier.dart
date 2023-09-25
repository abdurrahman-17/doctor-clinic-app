import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/getManagePrescription/getManagePrescriptionResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GetManagePrescriptionListNotifier extends BaseChangeNotifier {
  bool isloading = false;

  List<GetPrescriptionData> getPrescriptionClass = [];

  List<GetPrescriptionData> get GetPrescriptionClass => getPrescriptionClass;

  set GetPrescriptionClass(List<GetPrescriptionData> value) {
    getPrescriptionClass = value;
    notifyListeners();
  }

  Future<void> getManagePrescription(int doctorId) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url =
        DataConstants.LIVE_BASE_URL + DataConstants.GetManagePrescription;
    print(url);
    try {
      final input = {
        'doctor_id': doctorId.toString(),
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
      if (response.statusCode == 200) {
        final appointmentModel =
            getManagePrescriptionListResponseFromJson(response.body);
        GetPrescriptionClass = appointmentModel.data ?? [];
        notifyListeners();
      } else if (response.statusCode == 401) {
        appShowToast('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else {
        print('error');
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
