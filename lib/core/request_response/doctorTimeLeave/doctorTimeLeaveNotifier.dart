import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'doctorTimeLeaveResponse.dart';

class DoctorTimeLeaveNotifier extends BaseChangeNotifier {
  bool isloading = false;
  List<DoctorTimeLeaveData> doctorTimeLeaveClass = [];

  List<DoctorTimeLeaveData> get DoctorTimeLeaveClass => doctorTimeLeaveClass;

  set DoctorTimeLeaveClass(List<DoctorTimeLeaveData> value) {
    doctorTimeLeaveClass = value;
    notifyListeners();
  }

  String doctorTimeLeaveMessage = '';

  String get DoctorTimeLeaveMessage => doctorTimeLeaveMessage;

  set DoctorTimeLeaveMessage(String value) {
    doctorTimeLeaveMessage = value;
    notifyListeners();
  }

  Future<void> doctorTimeLeave(
    int id,
    String fromDate,
    String toDate,
    String fromTime,
    String toTime,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.DoctorTimeLeave;
    print(url);
    try {
      final input = {
        'doctor_id': id.toString(),
        'from_date': fromDate,
        'to_date': toDate,
        'from_time': fromTime,
        'to_time': toTime,
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
      final voucherTypeModel = doctorTimeLeaveResponseFromJson(response.body);
      if (response.statusCode == 200) {
        DoctorTimeLeaveClass = voucherTypeModel.data!;
        DoctorTimeLeaveMessage = voucherTypeModel.message.toString();

        notifyListeners();
      } else if (response.statusCode == 401) {
        print('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else {
        print('error');
        DoctorTimeLeaveMessage = voucherTypeModel.message.toString();
        print(DoctorTimeLeaveMessage);
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
