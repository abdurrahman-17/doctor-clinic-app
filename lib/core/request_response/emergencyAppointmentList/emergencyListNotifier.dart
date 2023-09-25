import 'dart:developer';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/emergencyAppointmentList/emergencyListResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/listOfPatient/listOfPatientResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/staffList/stafflistResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayDoneAppointment/todayDoneAppointmentResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyListNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<EmergencyListData> emergencyListClass = [];
  List<EmergencyListData> get EmergencyListClass => emergencyListClass;

  set EmergencyListClass(List<EmergencyListData> value) {
    emergencyListClass = value;
    notifyListeners();
  }

  Future<void> emergencyList(int id) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.EmergencyList;
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
      log(response.body);
      if (response.statusCode == 200) {
        final voucherTypeModel = emergencyAppointmentListResponseFromJson(response.body);
        EmergencyListClass = voucherTypeModel.data!;
        // log(voucherTypeModel.data![0].name.toString());
        notifyListeners();
      } else if (response.statusCode == 401) {
        print('You are unauthorized, please login again');
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
