import 'dart:convert';
import 'dart:developer';

import 'package:doctor_clinic_token_app/core/request_response/adddoctorSchedule/addDoctorScheduleResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/timedoctorschedule/timedoctorscheduleResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/tokendoctorschedule/tokendoctorscheduleResponse.dart';
import 'package:get/get.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'addDoctorScheduleTokenResponse.dart';

class AddDoctorScheduleTokenNotifier extends BaseChangeNotifier {
  AddDoctorScheduleTokenResponse addDoctorScheduleTokenResponse =
      AddDoctorScheduleTokenResponse();

  AddDoctorScheduleTokenNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> addDoctorScheduleToken(
      int doctorId,
      String scheduleName,
      int scheduleType,
      int slot1,
      int slot2,
      int slot3,
      int slot4,
      int slotDist1,
      int slotDist2,
      int slotDist3,
      int slotDist4,
      bool distributionCheck,
      String fromTimeDist1,
      String toTimeDist1,
      String fromTimeDist2,
      String toTimeDist2,
      String fromTimeDist3,
      String toTimeDist3,
      String fromTimeDist4,
      String toTimeDist4,
      String fromTime1,
      String toTime1,
      String fromTime2,
      String toTime2,
      String fromTime3,
      String toTime3,
      String fromTime4,
      String toTime4,
      List days) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url =
        DataConstants.LIVE_BASE_URL + DataConstants.AddDoctorScheduleToken;
    print(url);
    var input;
    var input1;

    consultingTimeCheck() {
      if (fromTime1 == 'null' && fromTime2 == 'null' && fromTime3 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          'from_time4': fromTime4,
          'to_time4': toTime4,
          'slot4': slot4,
          'days': days,
        };
      } else if (fromTime2 == 'null' &&
          fromTime3 == 'null' &&
          fromTime4 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'from_time1': fromTime1,
          'to_time1': toTime1,
          'slot1': slot1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime3 == 'null' &&
          fromTime4 == 'null' &&
          fromTime1 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          'from_time2': fromTime2,
          'to_time2': toTime2,
          'slot2': slot2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime2 == 'null' &&
          fromTime4 == 'null' &&
          fromTime1 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          //'from_time1': fromTime1,
          // 'to_time1': toTime1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          'from_time3': fromTime3,
          'to_time3': toTime3,
          'slot3': slot3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime1 == 'null' && fromTime2 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          'from_time3': fromTime3,
          'to_time3': toTime3,
          'slot3': slot3,
          'from_time4': fromTime4,
          'to_time4': toTime4,
          'slot4': slot4,
          'days': days,
        };
      } else if (fromTime2 == 'null' && fromTime3 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'from_time1': fromTime1,
          'to_time1': toTime1,
          'slot1': slot1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          'from_time4': fromTime4,
          'to_time4': toTime4,
          'slot4': slot4,
          'days': days,
        };
      } else if (fromTime3 == 'null' && fromTime4 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'from_time1': fromTime1,
          'to_time1': toTime1,
          'slot1': slot1,
          'from_time2': fromTime2,
          'to_time2': toTime2,
          'slot2': slot2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime1 == 'null' && fromTime3 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          // 'slot1': slot1,
          'from_time2': fromTime2,
          'to_time2': toTime2,
          'slot2': slot2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          // 'slot3': slot3,
          'from_time4': fromTime4,
          'to_time4': toTime4,
          'slot4': slot4,
          'days': days,
        };
      } else if (fromTime2 == 'null' && fromTime4 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'from_time1': fromTime1,
          'to_time1': toTime1,
          'slot1': slot1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          // 'slot2': slot2,
          'from_time3': fromTime3,
          'to_time3': toTime3,
          'slot3': slot3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime1 == 'null' && fromTime4 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          'from_time2': fromTime2,
          'to_time2': toTime2,
          'slot2': slot2,
          'from_time3': fromTime3,
          'to_time3': toTime3,
          'slot3': slot3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime1 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          'from_time2': fromTime2,
          'to_time2': toTime2,
          'slot2': slot2,
          'from_time3': fromTime3,
          'to_time3': toTime3,
          'slot3': slot3,
          'from_time4': fromTime4,
          'to_time4': toTime4,
          'slot4': slot4,
          'days': days,
        };
      } else if (fromTime2 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'from_time1': fromTime1,
          'to_time1': toTime1,
          'slot1': slot1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          'from_time3': fromTime3,
          'to_time3': toTime3,
          'slot3': slot3,
          'from_time4': fromTime4,
          'to_time4': toTime4,
          'slot4': slot4,
          'days': days,
        };
      } else if (fromTime3 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'from_time1': fromTime1,
          'to_time1': toTime1,
          'slot1': slot1,
          'from_time2': fromTime2,
          'to_time2': toTime2,
          'slot2': slot2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          'from_time4': fromTime4,
          'to_time4': toTime4,
          'slot4': slot4,
          'days': days,
        };
      } else if (fromTime4 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'from_time1': fromTime1,
          'to_time1': toTime1,
          'slot1': slot1,
          'from_time2': fromTime2,
          'to_time2': toTime2,
          'slot2': slot2,
          'from_time3': fromTime3,
          'to_time3': toTime3,
          'slot3': slot3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
      } else {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'from_time1': fromTime1,
          'to_time1': toTime1,
          'slot1': slot1,
          'from_time2': fromTime2,
          'to_time2': toTime2,
          'slot2': slot2,
          'from_time3': fromTime3,
          'to_time3': toTime3,
          'slot3': slot3,
          'from_time4': fromTime4,
          'to_time4': toTime4,
          'slot4': slot4,
          'days': days,
        };
      }
      return input1;
    }

    consultingDistTimeCheck() {
      if (fromTime1 == 'null' && fromTime2 == 'null' && fromTime3 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          'from_time4': fromTime4,
          'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime2 == 'null' &&
          fromTime3 == 'null' &&
          fromTime4 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'from_time1': fromTime1,
          'to_time1': toTime1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime3 == 'null' &&
          fromTime4 == 'null' &&
          fromTime1 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          'from_time2': fromTime2,
          'to_time2': toTime2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime2 == 'null' &&
          fromTime4 == 'null' &&
          fromTime1 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          //'from_time1': fromTime1,
          // 'to_time1': toTime1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          'from_time3': fromTime3,
          'to_time3': toTime3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime1 == 'null' && fromTime2 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          'from_time3': fromTime3,
          'to_time3': toTime3,
          'from_time4': fromTime4,
          'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime2 == 'null' && fromTime3 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'from_time1': fromTime1,
          'to_time1': toTime1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          'from_time4': fromTime4,
          'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime3 == 'null' && fromTime4 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'from_time1': fromTime1,
          'to_time1': toTime1,
          'from_time2': fromTime2,
          'to_time2': toTime2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime1 == 'null' && fromTime3 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          // 'slot1': slot1,
          'from_time2': fromTime2,
          'to_time2': toTime2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          // 'slot3': slot3,
          'from_time4': fromTime4,
          'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime2 == 'null' && fromTime4 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'from_time1': fromTime1,
          'to_time1': toTime1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          // 'slot2': slot2,
          'from_time3': fromTime3,
          'to_time3': toTime3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime1 == 'null' && fromTime4 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          'from_time2': fromTime2,
          'to_time2': toTime2,
          'from_time3': fromTime3,
          'to_time3': toTime3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime1 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          'from_time2': fromTime2,
          'to_time2': toTime2,
          'from_time3': fromTime3,
          'to_time3': toTime3,
          'from_time4': fromTime4,
          'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime2 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'from_time1': fromTime1,
          'to_time1': toTime1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          'from_time3': fromTime3,
          'to_time3': toTime3,
          'from_time4': fromTime4,
          'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime3 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'from_time1': fromTime1,
          'to_time1': toTime1,
          'from_time2': fromTime2,
          'to_time2': toTime2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          'from_time4': fromTime4,
          'to_time4': toTime4,
          'days': days,
        };
      } else if (fromTime4 == 'null') {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'from_time1': fromTime1,
          'to_time1': toTime1,
          'from_time2': fromTime2,
          'to_time2': toTime2,
          'from_time3': fromTime3,
          'to_time3': toTime3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
      } else {
        input1 = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'from_time1': fromTime1,
          'to_time1': toTime1,
          'from_time2': fromTime2,
          'to_time2': toTime2,
          'from_time3': fromTime3,
          'to_time3': toTime3,
          'from_time4': fromTime4,
          'to_time4': toTime4,
          'days': days,
        };
      }
      print(input1);
      print('Hijack');
      return input1;
    }

    if (distributionCheck == false) {
      input = consultingTimeCheck();
    } else {
      //////Heklmskdnjkdfsjdbcfnjsjncbsdhbcvh
      if (fromTimeDist1 == 'null' &&
          fromTimeDist2 == 'null' &&
          fromTimeDist3 == 'null') {
        input = {
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          'dis_from_time4': fromTimeDist4,
          'dis_to_time4': toTimeDist4,
          'slot4': slotDist4,
        };
        input.addAll(consultingDistTimeCheck());
      } else if (fromTimeDist2 == 'null' &&
          fromTimeDist3 == 'null' &&
          fromTimeDist4 == 'null') {
        input = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'dis_from_time1': fromTimeDist1,
          'dis_to_time1': toTimeDist1,
          'slot1': slotDist1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
        input.addAll(consultingDistTimeCheck());
      } else if (fromTimeDist3 == 'null' &&
          fromTimeDist4 == 'null' &&
          fromTimeDist1 == 'null') {
        input = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          'dis_from_time2': fromTimeDist2,
          'dis_to_time2': toTimeDist2,
          'slot2': slotDist2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
        input.addAll(consultingDistTimeCheck());
      } else if (fromTimeDist2 == 'null' &&
          fromTimeDist4 == 'null' &&
          fromTimeDist1 == 'null') {
        input = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          //'from_time1': fromTime1,
          // 'to_time1': toTime1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          'dis_from_time3': fromTimeDist3,
          'dis_to_time3': toTimeDist3,
          'slot3': slotDist3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
        input.addAll(consultingDistTimeCheck());
      } else if (fromTimeDist1 == 'null' && fromTimeDist2 == 'null') {
        input = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          'dis_from_time3': fromTimeDist3,
          'dis_to_time3': toTimeDist3,
          'slot3': slotDist3,
          'dis_from_time4': fromTimeDist4,
          'dis_to_time4': toTimeDist4,
          'slot4': slotDist4,
          'days': days,
        };
        input.addAll(consultingDistTimeCheck());
      } else if (fromTimeDist2 == 'null' && fromTimeDist3 == 'null') {
        input = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'dis_from_time1': fromTimeDist1,
          'dis_to_time1': toTimeDist1,
          'slot1': slotDist1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          'dis_from_time4': fromTimeDist4,
          'dis_to_time4': toTimeDist4,
          'slot4': slotDist4,
          'days': days,
        };
        input.addAll(consultingDistTimeCheck());
      } else if (fromTimeDist3 == 'null' && fromTimeDist4 == 'null') {
        input = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'dis_from_time1': fromTimeDist1,
          'dis_to_time1': toTimeDist1,
          'slot1': slotDist1,
          'dis_from_time2': fromTimeDist2,
          'dis_to_time2': toTimeDist2,
          'slot2': slotDist2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
        input.addAll(consultingDistTimeCheck());
      } else if (fromTimeDist1 == 'null' && fromTimeDist3 == 'null') {
        input = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          // 'slot1': slot1,
          'dis_from_time2': fromTimeDist2,
          'dis_to_time2': toTimeDist2,
          'slot2': slotDist2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          // 'slot3': slot3,
          'dis_from_time4': fromTimeDist4,
          'dis_to_time4': toTimeDist4,
          'slot4': slotDist4,
          'days': days,
        };
        input.addAll(consultingDistTimeCheck());
      } else if (fromTimeDist2 == 'null' && fromTimeDist4 == 'null') {
        input = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'dis_from_time1': fromTimeDist1,
          'dis_to_time1': toTimeDist1,
          'slot1': slotDist1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          // 'slot2': slot2,
          'dis_from_time3': fromTimeDist3,
          'dis_to_time3': toTimeDist3,
          'slot3': slotDist3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
        input.addAll(consultingDistTimeCheck());
      } else if (fromTimeDist1 == 'null' && fromTimeDist4 == 'null') {
        input = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          'dis_from_time2': fromTimeDist2,
          'dis_to_time2': toTimeDist2,
          'slot2': slotDist2,
          'dis_from_time3': fromTimeDist3,
          'dis_to_time3': toTimeDist3,
          'slot3': slotDist3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
        input.addAll(consultingDistTimeCheck());
      } else if (fromTimeDist1 == 'null') {
        input = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          // 'from_time1': fromTime1,
          // 'to_time1': toTime1,
          'dis_from_time2': fromTimeDist2,
          'dis_to_time2': toTimeDist2,
          'slot2': slotDist2,
          'dis_from_time3': fromTimeDist3,
          'dis_to_time3': toTimeDist3,
          'slot3': slotDist3,
          'dis_from_time4': fromTimeDist4,
          'dis_to_time4': toTimeDist4,
          'slot4': slotDist4,
          'days': days,
        };
        input.addAll(consultingDistTimeCheck());
      } else if (fromTimeDist2 == 'null') {
        input = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'dis_from_time1': fromTimeDist1,
          'dis_to_time1': toTimeDist1,
          'slot1': slotDist1,
          // 'from_time2': fromTime2,
          // 'to_time2': toTime2,
          'dis_from_time3': fromTimeDist3,
          'dis_to_time3': toTimeDist3,
          'slot3': slotDist3,
          'dis_from_time4': fromTimeDist4,
          'dis_to_time4': toTimeDist4,
          'slot4': slotDist4,
          'days': days,
        };
        input.addAll(consultingDistTimeCheck());
      } else if (fromTimeDist3 == 'null') {
        input = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'dis_from_time1': fromTimeDist1,
          'dis_to_time1': toTimeDist1,
          'slot1': slotDist1,
          'dis_from_time2': fromTimeDist2,
          'dis_to_time2': toTimeDist2,
          'slot2': slotDist2,
          // 'from_time3': fromTime3,
          // 'to_time3': toTime3,
          'dis_from_time4': fromTimeDist4,
          'dis_to_time4': toTimeDist4,
          'slot4': slotDist4,
          'days': days,
        };
        input.addAll(consultingDistTimeCheck());
      } else if (fromTimeDist4 == 'null') {
        input = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'dis_from_time1': fromTimeDist1,
          'dis_to_time1': toTimeDist1,
          'slot1': slotDist1,
          'dis_from_time2': fromTimeDist2,
          'dis_to_time2': toTimeDist2,
          'slot2': slotDist2,
          'dis_from_time3': fromTimeDist3,
          'dis_to_time3': toTimeDist3,
          'slot3': slotDist3,
          // 'from_time4': fromTime4,
          // 'to_time4': toTime4,
          'days': days,
        };
        input.addAll(consultingDistTimeCheck());
      } else {
        input = {
          'doctor_id': doctorId,
          'schedule_name': scheduleName,
          'schedule_type': scheduleType,
          'dis_from_time1': fromTimeDist1,
          'dis_to_time1': toTimeDist1,
          'slot1': slotDist1,
          'dis_from_time2': fromTimeDist2,
          'dis_to_time2': toTimeDist2,
          'slot2': slotDist2,
          'dis_from_time3': fromTimeDist3,
          'dis_to_time3': toTimeDist3,
          'slot3': slotDist3,
          'dis_from_time4': fromTimeDist4,
          'dis_to_time4': toTimeDist4,
          'slot4': slotDist4,
          'days': days,
        };
        input.addAll(consultingDistTimeCheck());
      }
    }
    print(json.encode(input));
    var body = json.encode(input);
    print(body);
    print("saadh check on input");
    final response = await http.post(Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
          'Content-Type': 'application/json',
          // 'Accept': 'application/json',
          // 'connection': 'keep-alive',
        },
        body: body);
    super.isLoading = false;
    log(response.body);
    print("saadh start");
    print(response.statusCode);

    if (response.statusCode == 200) {
      print("saadh end");
      try {
        final addDoctorScheduleTokenResponse =
            addDoctorScheduleTokenResponseFromJson(response.body);
        if (addDoctorScheduleTokenResponse.status == true) {
          Get.offAndToNamed(RoutePaths.ListAvailability, arguments: true);
        } else {
          appShowToast(addDoctorScheduleTokenResponse.message!);
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
