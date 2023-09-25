import 'dart:developer';
import 'package:doctor_clinic_token_app/Utils/common/app_locator.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/source/shared_pref/shared_pref.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../../../utils/common/app_route_paths.dart';
import 'getDoctorScheduleResponse.dart';

class GetDoctorScheduleNotifier extends BaseChangeNotifier {


  List doctor_details=[];
  bool isloading = false;
  GetDoctorScheduleTimeData doctor_Schedule_ResponseClass = GetDoctorScheduleTimeData();
  GetDoctorScheduleTimeData get Doctor_ScheduleResponseClass => doctor_Schedule_ResponseClass;

  set   Doctor_ScheduleResponseClass(GetDoctorScheduleTimeData value) {
    doctor_Schedule_ResponseClass = value;
    notifyListeners();
  }
  // List<AddedFamily> addedFamily_ResponseClass = [];
  // List<AddedFamily> get AddedFamilyResponseClass => addedFamily_ResponseClass;
  //
  // set AddedFamilyResponseClass(List<AddedFamily> value) {
  //   addedFamily_ResponseClass = value;
  //   notifyListeners();
  // }
  List<Afternoon> getDoctorSchedules_morning = [];
  List<Afternoon> get GetDoctorSchedules_Morning => getDoctorSchedules_morning;

  set GetDoctorSchedules_Morning(List<Afternoon> value) {
    getDoctorSchedules_morning = value;
    notifyListeners();
  }
  List<Afternoon> getDoctorSchedules_afternoon = [];
  List<Afternoon> get GetDoctorSchedules_Afternoon => getDoctorSchedules_afternoon;

  set GetDoctorSchedules_Afternoon(List<Afternoon> value) {
    getDoctorSchedules_afternoon = value;
    notifyListeners();
  }
  List<Afternoon> getDoctorSchedules_evening = [];
  List<Afternoon> get GetDoctorSchedules_Evening => getDoctorSchedules_afternoon;

  set GetDoctorSchedules_Evening(List<Afternoon> value) {
    getDoctorSchedules_evening = value;
    notifyListeners();
  }
  List<Afternoon> getDoctorSchedules_night = [];
  List<Afternoon> get GetDoctorSchedules_Night => getDoctorSchedules_afternoon;

  set GetDoctorSchedules_Night(List<Afternoon> value) {
    getDoctorSchedules_night = value;
    notifyListeners();
  }
  // List morning_ResponseClass = [];
  // List get MorningResponseClass => morning_ResponseClass;
  //
  // set   MorningResponseClass(value) {
  //   morning_ResponseClass = value;
  //   notifyListeners();
  // }

  Future<void> getDoctorScheduleTime(int id,String days,String date) async {
    super.isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.GetDoctorScheduleTime;
    print(url);
    try {
      final input = {'doctor_id': id.toString(),'days':days,'date':date};
      print(input);
      final response = await http.post(
        Uri.parse(url),
        body: input,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
          //'Authorization': 'Bearer ${_prefs.getToken()}',
          'Accept': 'application/json'
        },
      );
      log(response.body);

      if (response.statusCode == 200) {
        print('check');
        print(response.statusCode);
        final  doctor_details= getDoctorScheduleResponseFromJson(response.body);
        // print(doctor_details.data!.scheduleName.toString());
        // print(doctor_details.addedFamily!.length);
        Doctor_ScheduleResponseClass = doctor_details.data!;
        //print(Doctor_ScheduleResponseClass.morning);
        final addedfamily = getDoctorScheduleResponseFromJson(response.body);
        // AddedFamilyResponseClass = addedfamily.addedFamily!;
        final get_doctor_time = getDoctorScheduleResponseFromJson(response.body);
        GetDoctorSchedules_Morning = get_doctor_time.doctorSchedule!.morning ?? [];
        GetDoctorSchedules_Afternoon = get_doctor_time.doctorSchedule!.afternoon ?? [];
        GetDoctorSchedules_Evening = get_doctor_time.doctorSchedule!.evening ?? [];
        GetDoctorSchedules_Night = get_doctor_time.doctorSchedule!.night ?? [];
        // print('abdul');
        // print(GetDoctorSchedules_Morning[0].time);
        // final Mor = getDoctorScheduleFromJson(response.body);
        // // MorningResponseClass = Mor.data!.thu!.morning;
        // print('irfan');
        // print(AddedFamilyResponseClass.length);
        //log(voucherTypeModel.data![0].id.toString());
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
    super.isLoading = false;
  }
}
