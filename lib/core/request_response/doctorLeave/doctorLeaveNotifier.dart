import 'dart:convert';
import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorLeave/doctorLeaveResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DoctorLeaveNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<DoctorLeaveData> doctorLeaveClass = [];

  List<DoctorLeaveData> get DoctorLeaveClass => doctorLeaveClass;

  set DoctorLeaveClass(List<DoctorLeaveData> value) {
    doctorLeaveClass = value;
    notifyListeners();
  }

  String doctorLeaveMessage = '';

  String get DoctorLeaveMessage => doctorLeaveMessage;

  set DoctorLeaveMessage(String value) {
    doctorLeaveMessage = value;
    notifyListeners();
  }

  Future<void> doctorLeave(int id, String fromDate, String toDate) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.DoctorLeave;
    print(url);
    try {
      final input = {
        'doctor_id': id.toString(),
        'from_date': fromDate,
        'to_date': toDate,
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
      final voucherTypeModel = doctorLeaveResponseFromJson(response.body);
      if (response.statusCode == 200) {
        DoctorLeaveClass = voucherTypeModel.data!;
        DoctorLeaveMessage = voucherTypeModel.message.toString();

        // log(voucherTypeModel.data![0].name.toString());
        notifyListeners();
      } else if (response.statusCode == 401) {
        print('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else {
        print('error');
        DoctorLeaveMessage = voucherTypeModel.message.toString();
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
