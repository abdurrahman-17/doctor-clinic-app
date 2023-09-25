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

class AddDoctorScheduleNotifier extends BaseChangeNotifier {
  AddDoctorScheduleResponse addDoctorScheduleResponse = AddDoctorScheduleResponse();

  AddDoctorScheduleNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> addDoctorSchedule(
      int doctorId,
      String scheduleName,
      int slotTime,
      int scheduleType,
      int slotPerMember,
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
    String url = DataConstants.LIVE_BASE_URL + DataConstants.AddDoctorSchedule;
    print(url);
    final input;
    if(fromTime1 == 'null' && fromTime2 == 'null' && fromTime3 == 'null'){
       input = {
        'doctor_id': doctorId,
        'schedule_name': scheduleName,
        'slot': slotTime,
        'schedule_type': scheduleType,
        'slot_member': slotPerMember,
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
    }else if(fromTime2 == 'null' && fromTime3 == 'null' && fromTime4 == 'null'){
       input = {
        'doctor_id': doctorId,
        'schedule_name': scheduleName,
        'slot': slotTime,
        'schedule_type': scheduleType,
        'slot_member': slotPerMember,
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
    }else if(fromTime3 == 'null' && fromTime4 == 'null' && fromTime1 == 'null'){
       input = {
        'doctor_id': doctorId,
        'schedule_name': scheduleName,
        'slot': slotTime,
        'schedule_type': scheduleType,
        'slot_member': slotPerMember,
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
    }else if(fromTime2 == 'null' && fromTime4 == 'null' && fromTime1 == 'null'){
       input = {
        'doctor_id': doctorId,
        'schedule_name': scheduleName,
        'slot': slotTime,
        'schedule_type': scheduleType,
        'slot_member': slotPerMember,
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
    }else if(fromTime1 == 'null' && fromTime2 == 'null' ){
       input = {
        'doctor_id': doctorId,
        'schedule_name': scheduleName,
        'slot': slotTime,
        'schedule_type': scheduleType,
        'slot_member': slotPerMember,
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
    } else if(fromTime2 == 'null' && fromTime3 == 'null' ){
       input = {
        'doctor_id': doctorId,
        'schedule_name': scheduleName,
        'slot': slotTime,
        'schedule_type': scheduleType,
        'slot_member': slotPerMember,
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
    }else if(fromTime3 == 'null' && fromTime4 == 'null' ){
       input = {
        'doctor_id': doctorId,
        'schedule_name': scheduleName,
        'slot': slotTime,
        'schedule_type': scheduleType,
        'slot_member': slotPerMember,
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
    }else if(fromTime1 == 'null' && fromTime3 == 'null' ){
      input = {
        'doctor_id': doctorId,
        'schedule_name': scheduleName,
        'slot': slotTime,
        'schedule_type': scheduleType,
        'slot_member': slotPerMember,
        // 'from_time1': fromTime1,
        // 'to_time1': toTime1,
        'from_time2': fromTime2,
        'to_time2': toTime2,
        // 'from_time3': fromTime3,
        // 'to_time3': toTime3,
        'from_time4': fromTime4,
        'to_time4': toTime4,
        'days': days,
      };
    }else if(fromTime2 == 'null' && fromTime4 == 'null' ){
      input = {
        'doctor_id': doctorId,
        'schedule_name': scheduleName,
        'slot': slotTime,
        'schedule_type': scheduleType,
        'slot_member': slotPerMember,
        'from_time1': fromTime1,
        'to_time1': toTime1,
        // 'from_time2': fromTime2,
        // 'to_time2': toTime2,
        'from_time3': fromTime3,
        'to_time3': toTime3,
        // 'from_time4': fromTime4,
        // 'to_time4': toTime4,
        'days': days,
      };
    }else if(fromTime1 == 'null' && fromTime4 == 'null' ){
       input = {
        'doctor_id': doctorId,
        'schedule_name': scheduleName,
        'slot': slotTime,
        'schedule_type': scheduleType,
        'slot_member': slotPerMember,
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
    }else if(fromTime1 == 'null'){
       input = {
        'doctor_id': doctorId,
        'schedule_name': scheduleName,
        'slot': slotTime,
        'schedule_type': scheduleType,
        'slot_member': slotPerMember,
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
    } else if(fromTime2 == 'null'){
       input = {
        'doctor_id': doctorId,
        'schedule_name': scheduleName,
        'slot': slotTime,
        'schedule_type': scheduleType,
        'slot_member': slotPerMember,
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
    } else if(fromTime3 == 'null'){
      input = {
        'doctor_id': doctorId,
        'schedule_name': scheduleName,
        'slot': slotTime,
        'schedule_type': scheduleType,
        'slot_member': slotPerMember,
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
    } else if(fromTime4 == 'null'){
      input = {
        'doctor_id': doctorId,
        'schedule_name': scheduleName,
        'slot': slotTime,
        'schedule_type': scheduleType,
        'slot_member': slotPerMember,
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
    }else{
      input = {
        'doctor_id': doctorId,
        'schedule_name': scheduleName,
        'slot': slotTime,
        'schedule_type': scheduleType,
        'slot_member': slotPerMember,
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
    print(json.encode(input));
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
    final addDoctorScheduleResponse =
    addDoctorScheduleResponseFromJson(response.body);
    appShowToast(addDoctorScheduleResponse.message.toString());
    if (response != null && response.statusCode == 200) {
      print("saadh end");
      try {

        if (addDoctorScheduleResponse.status == true) {
          Get.offAndToNamed(RoutePaths.ListAvailability, arguments: true);
          appShowToast(addDoctorScheduleResponse.message.toString());
        } else {
          appShowToast(addDoctorScheduleResponse.message.toString());
        }
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    } else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    } else{
      appShowToast(addDoctorScheduleResponse.message.toString());
    }
  }
}
