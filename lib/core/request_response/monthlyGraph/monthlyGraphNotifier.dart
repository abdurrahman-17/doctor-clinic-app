import 'dart:developer';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/graphWeek/graphWeekResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/listOfPatient/listOfPatientResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/staffList/stafflistResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayDoneAppointment/todayDoneAppointmentResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'monthlyGraphResponse.dart';

class GraphMonthNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<MonthlyReport> graphMonthlyClass = [];
  List<MonthlyReport> get GraphMonthlyClass => graphMonthlyClass;

  set GraphMonthlyClass(List<MonthlyReport> value) {
    graphMonthlyClass = value;
    notifyListeners();
  }

  Future<void> graphMonthly(int id) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.GraphMonthly;
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
        final voucherTypeModel = monthlyGraphResponseFromJson(response.body);
        GraphMonthlyClass = voucherTypeModel.monthlyReport!;
        // log(voucherTypeModel.data![0].name.toString());
        notifyListeners();
      } else if (response.statusCode == 401) {
        print('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else {
        print('Invalid Doctor, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
