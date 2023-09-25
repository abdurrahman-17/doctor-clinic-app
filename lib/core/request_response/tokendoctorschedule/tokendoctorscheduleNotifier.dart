import 'dart:convert';
import 'dart:developer';

import 'package:doctor_clinic_token_app/core/request_response/timedoctorschedule/timedoctorscheduleResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/tokendoctorschedule/tokendoctorscheduleResponse.dart';
import 'package:get/get.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TokenDoctorScheduleNotifier extends BaseChangeNotifier {
  TokenDoctorScheduleResponse? tokenDoctorScheduleResponse;

  TokenDoctorScheduleNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> tokenDoctorSchedule(
      int doctorId,
      String scheduleName,
      int slotToken,
      int slotType,
      String fromTime,
      String toTime,
      List days) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.TokenDoctorScheduler;
    print(url);
    final input = {
      'doctor_id': doctorId,
      'schedule_name': scheduleName,
      'slot': slotToken,
      'schedule_type': slotType,
      'from_time': fromTime,
      'to_time': toTime,
      'days': days,
    };
    var body = json.encode(input);
    print(body);
    print("saadh check on input");
    final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
          'Content-Type': 'application/json',
          // 'Accept': 'application/json',
          // 'connection': 'keep-alive',
        },
        body: body
    );
    super.isLoading = false;
    log(response.body);
    print("saadh start");
    print(response.statusCode);


    if (response != null && response.statusCode == 200) {
      print("saadh end");
      try {
        final tokenDoctorScheduleResponse =
        tokenDoctorScheduleResponseFromJson(response.body);
        if (tokenDoctorScheduleResponse.status == true) {
          Get.toNamed(RoutePaths.ListAvailability, arguments: true);
        } else {
          appShowToast(tokenDoctorScheduleResponse.message!);
        }
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    } else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    }
  }
}
