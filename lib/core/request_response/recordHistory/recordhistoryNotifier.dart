import 'dart:developer';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/recordHistory/recordhistoryResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/todayconsultation/todayconsultationResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RecordHistoryNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<RecordHistoryData> recordHistoryClass = [];
  List<RecordHistoryData> get RecordHistoryClass => recordHistoryClass;

  set RecordHistoryClass(List<RecordHistoryData> value) {
    recordHistoryClass = value;
    notifyListeners();
  }

  Future<void> recordHistory(String id) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.RecordHistory;
    print(url);
    try {
      final input = {'patient_id': id.toString()};
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
      final voucherTypeModel = recordHistoryResponseFromJson(response.body);
      if (response.statusCode == 200) {
        final voucherTypeModel = recordHistoryResponseFromJson(response.body);
        RecordHistoryClass = voucherTypeModel.data!;
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
