import 'dart:developer';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'getAllNotificationResponse.dart';

class GetAllNotificationNotifier extends BaseChangeNotifier {
  bool isloading = false;

  List<NotificationResponseData> notificationResponseClass = [];
  List<NotificationResponseData> get NotificationResponseClass =>
      notificationResponseClass;

  set NotificationResponseClass(List<NotificationResponseData> value) {
    notificationResponseClass = value;
    notifyListeners();
  }

  List<NotificationResponseData> earlierNotificationResponseClass = [];
  List<NotificationResponseData> get EarlierNotificationResponseClass =>
      earlierNotificationResponseClass;

  set EarlierNotificationResponseClass(List<NotificationResponseData> value) {
    earlierNotificationResponseClass = value;
    notifyListeners();
  }

  String notificationCount = '';
  String? message;

  Future<void> getNotificationData(int doctorId) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url =
        DataConstants.LIVE_BASE_URL + DataConstants.GetAllNotifications;
    print(url);
    try {
      final input = {
        'doctor_id': doctorId.toString(),
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
      final Notification_data = notificationFromJson(response.body);
      if (response.statusCode == 200) {
        final Notification_data = notificationFromJson(response.body);
        notificationCount = Notification_data.readStatus.toString();
        print('praveen');
        print(notificationCount);
        NotificationResponseClass = Notification_data.data ?? [];
        EarlierNotificationResponseClass = Notification_data.yearlier ?? [];
        log(Notification_data.data![0].title.toString());
        notifyListeners();
      } else if (response.statusCode == 401) {
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
