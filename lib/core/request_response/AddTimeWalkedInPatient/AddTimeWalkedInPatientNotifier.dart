import 'dart:developer';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/AddTimeWalkedInPatient/AddTimeWalkedInPatientResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/common/app_route_paths.dart';

class AddTimeWalkedInPatientNotifier extends BaseChangeNotifier {

  List doctor_details=[];
  bool isloading = false;
  TimeWalkedInData timeWalkedInDataClass = TimeWalkedInData();
  TimeWalkedInData get TimeWalkedInDataClass => timeWalkedInDataClass;

  set TimeWalkedInDataClass(TimeWalkedInData value) {
    timeWalkedInDataClass = value;
    notifyListeners();
  }

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

  Future<void> get_Doctor_Schedule(int id,String days,String patient_id,String date) async {
    super.isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.TimeWalkedPatient;
    print(url);
    try {
      final input = {'doctor_id': id.toString(),'days':days,'patient_id':patient_id,'date':date};
      print(input);
      final response = await http.post(
        Uri.parse(url),
        body: input,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('token')}',
          //'Authorization': 'Bearer ${_prefs.getToken()}',
          'Accept': 'application/json'
        },
      );
      log(response.body);

      if (response.statusCode == 200) {
        print('check');
        print(response.statusCode);
        final  doctor_details= addTimeWalkedInPatientResponseFromJson(response.body);
        // print(doctor_details.data!.scheduleName.toString());
        // print(doctor_details.addedFamily!.length);
        TimeWalkedInDataClass = doctor_details.data!;
        //print(Doctor_ScheduleResponseClass.morning);
        final get_doctor_time = addTimeWalkedInPatientResponseFromJson(response.body);
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