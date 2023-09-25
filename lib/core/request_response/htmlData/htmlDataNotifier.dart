import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/htmlData/htmlDataResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HTMLDataNotifier extends BaseChangeNotifier {
  bool isloading = false;

  String htmlResponseClass = '';
  String htmlResponseMessage = '';

  String get HtmlResponseClass => htmlResponseClass;

  set HtmlResponseClass(String value) {
    htmlResponseClass = value;
    notifyListeners();
  }

  String get HtmlResponseMessage => htmlResponseMessage;

  set HtmlResponseMessage(String value) {
    htmlResponseMessage = value;
    notifyListeners();
  }

  Future<void> htmlResponse(int appointmentId) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.HTMLDataFormat;
    print(url);
    try {
      final input = {
        'appoinment_id': appointmentId.toString(),
      };
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
      final appointmentModel = htmlDataResponseFromJson(response.body);
      if (response.statusCode == 200) {
        HtmlResponseClass = appointmentModel.data.toString();
        HtmlResponseMessage = appointmentModel.message.toString();
        notifyListeners();
      } else if (response.statusCode == 401) {
        appShowToast('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else {
        print('error');
        HtmlResponseMessage = appointmentModel.message.toString();
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
