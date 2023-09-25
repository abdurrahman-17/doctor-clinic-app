import 'dart:developer';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorLeaveDays/doctorLeaveDaysResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/listOfPatient/listOfPatientResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/staffList/stafflistResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayDoneAppointment/todayDoneAppointmentResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DoctorLeaveDaysNotifier extends BaseChangeNotifier {
  bool isloading = false;
  List<LeaveDaysData> doctorLeaveDaysClass = [];
  List<LeaveDaysData> get DoctorLeaveDaysClass => doctorLeaveDaysClass;

  set DoctorLeaveDaysClass(List<LeaveDaysData> value) {
    doctorLeaveDaysClass = value;
    notifyListeners();
  }

  String msg = '';
  DoctorLeaveDaysResponse doctorLeaveDaysMessageClass =
      DoctorLeaveDaysResponse();
  DoctorLeaveDaysResponse get DoctorLeaveDaysMessageClass =>
      doctorLeaveDaysMessageClass;

  set DoctorLeaveDaysMessageClass(DoctorLeaveDaysResponse value) {
    doctorLeaveDaysMessageClass = value;
    notifyListeners();
  }

  Future<void> doctorLeaveDays(int id) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.DoctorLeaveDays;
    print(url);
    try {
      final input = {'doctor_id': id.toString()};
      print(input);
      final response = await http.post(
        Uri.parse(url),
        body: input,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
          'Accept': 'application/json'
        },
      );
      final voucherTypeModel = doctorLeaveDaysResponseFromJson(response.body);
      log(response.body);
      if (response.statusCode == 200) {
        final voucherTypeModel = doctorLeaveDaysResponseFromJson(response.body);
        DoctorLeaveDaysClass = voucherTypeModel.data!;
        msg = voucherTypeModel.message.toString();

        notifyListeners();
      } else if (response.statusCode == 401) {
        print('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else {
        msg = voucherTypeModel.message.toString();
        print('error');
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
