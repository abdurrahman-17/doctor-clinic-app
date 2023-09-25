import 'dart:developer';

import 'package:doctor_clinic_token_app/View/List%20Of%20Availability/list_availability.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/availabilityDeleteConfirm/availabilityDeleteConfirmResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AvailabilityDeleteConfirmNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  AvailabilityDeleteConfirmData availabilityDeleteConfirmClass =
      AvailabilityDeleteConfirmData();

  AvailabilityDeleteConfirmData get AvailabilityDeleteConfirmClass =>
      availabilityDeleteConfirmClass;

  set AvailabilityDeleteConfirmClass(AvailabilityDeleteConfirmData value) {
    availabilityDeleteConfirmClass = value;
    notifyListeners();
  }

  Future<void> availabilityDeleteConfirm(
    int id,
    String days,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url =
        DataConstants.LIVE_BASE_URL + DataConstants.AvailabilityDeleteConfirm;
    print(url);
    try {
      final input = {
        'doctor_id': id.toString(),
        'day': days.toString(),
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
        final voucherTypeModel =
            availabilityDeleteConfirmResponseFromJson(response.body);
        AvailabilityDeleteConfirmClass = voucherTypeModel.data!;
        // log(voucherTypeModel.data![0].name.toString());
        Get.back();
        Get.back();
        Get.to(ListOfAVilability());
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
