

import 'dart:developer';
import 'package:doctor_clinic_token_app/Router.dart';
import 'package:doctor_clinic_token_app/View/login/login.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayConsulationCount/todayconsultationcountResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/common/app_locator.dart';
import '../../source/shared_pref/shared_pref.dart';

class TodayConsultationCountNotifiers extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  ConsultData todayConsultationResponseClass = ConsultData();
  ConsultData get TodayConsultationResponseClass => todayConsultationResponseClass;

  set TodayConsultationResponseClass(ConsultData value) {
    todayConsultationResponseClass = value;
    notifyListeners();
  }

  Future<void> todayConsultationCount(int id) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;

    String url = DataConstants.LIVE_BASE_URL + DataConstants.ConsultationCount;
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
        final voucherTypeModel = todayConsultationCountResponseFromJson(response.body);
        TodayConsultationResponseClass = voucherTypeModel.data!;
        notifyListeners();
      } else if (response.statusCode == 401) {
        appShowToast('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else {
        appShowToast('Invalid Doctor, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}