import 'dart:developer';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/graphWeek/graphWeekResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/listOfPatient/listOfPatientResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/pieChart/pieChartResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/staffList/stafflistResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayDoneAppointment/todayDoneAppointmentResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PieChartNotifier extends BaseChangeNotifier {
  bool isloading = false;
  List<MonthlyPieReport> pieChartClass = [];
  List<MonthlyPieReport> get PieChartClass => pieChartClass;

  set PieChartClass(List<MonthlyPieReport> value) {
    pieChartClass = value;
    notifyListeners();
  }

  int allAppointmentClass = 0;
  int get AllAppointmentClass => allAppointmentClass;

  set AllAppointmentClass(int value) {
    allAppointmentClass = value;
    notifyListeners();
  }

  int walkedInClass = 0;
  int get WalkedInClass => walkedInClass;

  set WalkedInClass(int value) {
    walkedInClass = value;
    notifyListeners();
  }

  int emergencyClass = 0;
  int get EmergencyClass => emergencyClass;

  set EmergencyClass(int value) {
    emergencyClass = value;
    notifyListeners();
  }

  Future<void> pieChart(int id) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.PieChart;
    print(url);

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
    final voucherTypeModel = pieChartResponseFromJson(response.body);
    try {
      if (response.statusCode == 200) {
        final voucherTypeModel = pieChartResponseFromJson(response.body);
        PieChartClass = voucherTypeModel.monthlyReport!;
        AllAppointmentClass = PieChartClass[0].allAppoinmentCount!;
        WalkedInClass = PieChartClass[1].wakinAppoinmentCount!;
        EmergencyClass = PieChartClass[2].emgerencyAppoinmentCount!;
        print('Hii');
        print(AllAppointmentClass);
        print(WalkedInClass);
        print(EmergencyClass);

        notifyListeners();
      } else if (response.statusCode == 401) {
        print('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else if (response.statusCode == 404) {
        PieChartClass = voucherTypeModel.monthlyReport!;
        AllAppointmentClass = PieChartClass[0].allAppoinmentCount!;
        WalkedInClass = PieChartClass[1].wakinAppoinmentCount!;
        EmergencyClass = PieChartClass[2].emgerencyAppoinmentCount!;
      } else {
        print('Invalid Doctor, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      }
    } catch (e) {
      print(e);
      PieChartClass = voucherTypeModel.monthlyReport!;
      AllAppointmentClass = PieChartClass[0].allAppoinmentCount!;
      WalkedInClass = PieChartClass[1].wakinAppoinmentCount!;
      EmergencyClass = PieChartClass[2].emgerencyAppoinmentCount!;
      print('Hii');
      print(AllAppointmentClass);
      print(WalkedInClass);
      print(EmergencyClass);
    }
    isLoading = false;
  }
}
