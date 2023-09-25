import 'dart:developer';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/readNotification/readNotificationResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReadNotificationNotfier extends BaseChangeNotifier {
  ReadNotification? readNotification;

  ReadNotificationNotfier() {
  }


  Future<void> read_Notification_Data(String id) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.readNotification;
    print(url);
    final input = {'doctor_id': id};
    print(input);
    final response = await http.post(
      Uri.parse(url),
      body: (input),
      headers: {
        'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
        'Accept': 'application/json'
      },
    );
    super.isLoading = false;
    log(response.body);
    if (response != null && response.statusCode == 200) {
      try {
        final read_Notificationdata =
        readNotificationFromJson(response.body);
        if (read_Notificationdata.status == true) {

        } else {
          appShowToast(read_Notificationdata.message!);
        }
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    }else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    }
  }

}
