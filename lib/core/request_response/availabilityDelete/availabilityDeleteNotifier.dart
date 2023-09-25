import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/availabilityDelete/availabilityDeleteResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorLeave/doctorLeaveResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/listofavailability/listofavailabilityResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AvailabilityDeleteNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<AvialbilityDeleteData> avialbilityDeleteClass = [];

  List<AvialbilityDeleteData> get AvialbilityDeleteClass => avialbilityDeleteClass;

  set AvialbilityDeleteClass(List<AvialbilityDeleteData> value) {
    avialbilityDeleteClass = value;
    notifyListeners();
  }

  Future<void> avialbilityDelete(int id, String day) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.AvailabilityDelete;
    print(url);
    try {
      final input = {
        'doctor_id': id.toString(),
        'day': day,
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
      if (response.statusCode == 200) {
        final voucherTypeModel = availabilityDeleteResponseFromJson(response.body);
        AvialbilityDeleteClass = voucherTypeModel.data!;

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
