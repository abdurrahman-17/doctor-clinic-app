import 'dart:convert';
import 'dart:developer';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayCheckIn/todaycheckinResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TodayCheckedInNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<CheckedInData> todayCheckinClass = [];
  List<CheckedInData> get TodayCheckedInClass => todayCheckinClass;

  set   TodayCheckedInClass(List<CheckedInData> value) {
    todayCheckinClass = value;
    notifyListeners();
  }

  Future<void> todayCheckIn(int id) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.TodayCheckIn;
    print(url);
    try {
      final input = {'doctor_id': id.toString()};
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
        final voucherTypeModel = todayCheckedInResponseFromJson(response.body);
        TodayCheckedInClass = voucherTypeModel.data!;
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
