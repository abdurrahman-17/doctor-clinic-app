import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/recordHistoryFilter/recordHistoryFilterResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RecordHistoryFilterNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<RecordHistoryFilterData> recordHistoryFilterClass = [];

  List<RecordHistoryFilterData> get RecordHistoryFilterClass =>
      recordHistoryFilterClass;

  set RecordHistoryFilterClass(List<RecordHistoryFilterData> value) {
    recordHistoryFilterClass = value;
    notifyListeners();
  }

  Future<void> recordHistoryFilter(String id, String filterData) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url =
        DataConstants.LIVE_BASE_URL + DataConstants.RecordHistoryFilter;
    print(url);
    try {
      final input = {
        'patient_id': id.toString(),
        'date': filterData.toString(),
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
      final voucherTypeModel =
          recordHistoryFilterResponseFromJson(response.body);
      if (response.statusCode == 200) {
        final voucherTypeModel =
            recordHistoryFilterResponseFromJson(response.body);
        RecordHistoryFilterClass = voucherTypeModel.data!;
        // log(voucherTypeModel.data![0].name.toString());
        notifyListeners();
      } else if (response.statusCode == 401) {
        print('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else if (voucherTypeModel.message == " No record found ") {
        print('no data');
        RecordHistoryFilterClass = [];
        notifyListeners();
      } else {
        print('error');
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
