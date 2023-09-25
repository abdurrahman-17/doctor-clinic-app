import 'dart:developer';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/common/app_route_paths.dart';
import 'getDoctorScheduleTokenResponse.dart';


class GetDoctorTokenScheduleNotifier extends BaseChangeNotifier {

  bool isloading = false;
  getTokenData doctor_token_Schedule_ResponseClass = getTokenData();
  getTokenData get Doctor_Token_ScheduleResponseClass => doctor_token_Schedule_ResponseClass;

  set   Doctor_Token_ScheduleResponseClass(getTokenData value) {
    doctor_token_Schedule_ResponseClass = value;
    notifyListeners();
  }

  List<Afternoon> getDoctorSchedules_morning_token = [];
  List<Afternoon> get GetDoctorSchedules_Morning_Token => getDoctorSchedules_morning_token;

  set GetDoctorSchedules_Morning_Token(List<Afternoon> value) {
    getDoctorSchedules_morning_token = value;
    notifyListeners();
  }
  List<Afternoon> getDoctorSchedules_afternoon_token = [];
  List<Afternoon> get GetDoctorSchedules_Afternoon_Token => getDoctorSchedules_afternoon_token;

  set GetDoctorSchedules_Afternoon_Token(List<Afternoon> value) {
    getDoctorSchedules_afternoon_token = value;
    notifyListeners();
  }
  List<Afternoon> getDoctorSchedules_evening_token = [];
  List<Afternoon> get GetDoctorSchedules_Evening_Token => getDoctorSchedules_evening_token;

  set GetDoctorSchedules_Evening_Token(List<Afternoon> value) {
    getDoctorSchedules_evening_token = value;
    notifyListeners();
  }
  List<Afternoon> getDoctorSchedules_night_token = [];
  List<Afternoon> get GetDoctorSchedules_Night_Token => getDoctorSchedules_night_token;

  set GetDoctorSchedules_Night_Token(List<Afternoon> value) {
    getDoctorSchedules_night_token = value;
    notifyListeners();
  }
  // List<AddedFamily> addedFamily_ResponseClass = [];
  // List<AddedFamily> get AddedFamilyResponseClass => addedFamily_ResponseClass;
  //
  // set   AddedFamilyResponseClass(List<AddedFamily> value) {
  //   addedFamily_ResponseClass = value;
  //   notifyListeners();
  // }

  Future<void> getDoctortokenSchedule(int id,String days,String date) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.GetDoctorScheduleToken;
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
        final get_token_schedule = getDoctorScheduleTokenResponseFromJson(response.body);
        Doctor_Token_ScheduleResponseClass = get_token_schedule.data!;
        GetDoctorSchedules_Morning_Token=get_token_schedule.doctorSchedule!.morning ?? [];
        GetDoctorSchedules_Afternoon_Token=get_token_schedule.doctorSchedule!.afternoon ?? [];
        GetDoctorSchedules_Evening_Token=get_token_schedule.doctorSchedule!.evening ?? [];
        GetDoctorSchedules_Night_Token=get_token_schedule.doctorSchedule!.night ?? [];
        //AddedFamilyResponseClass = get_token_schedule.addedFamily!;

        notifyListeners();
      }else if (response.statusCode == 401) {
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
