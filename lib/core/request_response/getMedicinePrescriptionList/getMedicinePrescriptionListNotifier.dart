import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'getMedicinePrescriptionListResponse.dart';

class GetMedicinePrescriptionListNotifier extends BaseChangeNotifier {
  bool isloading = false;

  List<GetMedicinePrescriptionListData> getMedicinePrescriptionListClass = [];

  List<GetMedicinePrescriptionListData> get GetMedicinePrescriptionListClass =>
      getMedicinePrescriptionListClass;

  set GetMedicinePrescriptionListClass(
      List<GetMedicinePrescriptionListData> value) {
    getMedicinePrescriptionListClass = value;
    notifyListeners();
  }

  Future<void> getMedicinePrescriptionList(int appointmentId) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url =
        DataConstants.LIVE_BASE_URL + DataConstants.GetMedicinePrescriptionList;
    print(url);
    try {
      final input = {
        'appoinment_id': appointmentId.toString(),
      };
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
            getMedicinePrescriptionListResponseFromJson(response.body);

        GetMedicinePrescriptionListClass = appointmentModel.data!;

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
