import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'listofavailabilityResponse.dart';

class ListOfAvailabilityNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<AvailabilityData> listOfAvailabilityClass = [];

  List<AvailabilityData> get ListOfAvailabilityClass => listOfAvailabilityClass;

  set ListOfAvailabilityClass(List<AvailabilityData> value) {
    listOfAvailabilityClass = value;
    notifyListeners();
  }

  Future<void> listAvailabilty(int id, String day, String switchValue) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.ListOfAvailability;
    print(url);
    try {
      final input = {
        'doctor_id': id.toString(),
      };

      final statusInput = {
        'doctor_id': id.toString(),
        'days': day,
        'status': switchValue.toString(),
      };


      print(input);
      final response = await http.post(
        Uri.parse(url),
        body: switchValue == 'null' ? input : statusInput,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
          'Accept': 'application/json'
        },
      );
      log(response.body);
      final voucherTypeModel =
      availabilityListResponseFromJson(response.body);
      if (response.statusCode == 200) {
        final voucherTypeModel =
            availabilityListResponseFromJson(response.body);
        ListOfAvailabilityClass = voucherTypeModel.data!;
        notifyListeners();
      } else if (response.statusCode == 401) {
        print('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else {
        appShowToast(voucherTypeModel.message.toString());
      }
    } catch (e) {
      print(e.toString());
    }
    isLoading = false;
  }
}
