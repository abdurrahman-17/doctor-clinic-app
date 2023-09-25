import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'notification_Count_Response.dart';

class NotificationCountNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;

  String Notification_count = '';
  String? message;

  Future<void> Notification_count_data(String id) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.Notificationcount;
    print(url);
    try {
      final input = {'doctor_id': id,};
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
      final Notification_data = notificationCountFromJson(response.body);
      if (response.statusCode == 200) {
        final Notification_data = notificationCountFromJson(response.body);
        Notification_count = Notification_data.notificationCount.toString();

        log(Notification_data.notificationCount.toString());
        notifyListeners();
      } else if (response.statusCode == 401) {
        final prefs = await SharedPreferences.getInstance();
        prefs.clear();
        MySharedPreferences.instance.removeAll();
        appShowToast('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else {
        print(response.statusCode);
        print('abdul');
        print('error');
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
