import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorScheduleDayStatus/doctorScheduleDayStatusResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DoctorScheduleDayStatusNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<Day> dayScheduleStatusClass = [];

  List<Day> get DayScheduleStatusClass => dayScheduleStatusClass;

  set DayScheduleStatusClass(List<Day> value) {
    dayScheduleStatusClass = value;
    notifyListeners();
  }

  Future<void> doctorScheduleStatus(int id) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.DoctorScheduleDayStatus;
    print(url);
    try {
      final input = {
        'doctor_id': id.toString(),
      };

      print(input);
      final response = await http.post(
        Uri.parse(url),
        body: input ,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
          'Accept': 'application/json'
        },
      );
      log(response.body);
      final voucherTypeModel =
      doctorScheduleDayStatusFromJson(response.body);
      if (response.statusCode == 200) {
        final voucherTypeModel =
        doctorScheduleDayStatusFromJson(response.body);
        DayScheduleStatusClass = voucherTypeModel.data!.days ?? [];
        notifyListeners();
      } else if (response.statusCode == 401) {
        print('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else {
        appShowToast(voucherTypeModel.message.toString());
      }
    } catch (e) {
      print(e.toString());
    }
    isLoading = false;
  }
}
