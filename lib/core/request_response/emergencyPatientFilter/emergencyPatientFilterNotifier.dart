import 'dart:developer';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/emergencyPatientFilter/emergencyPatientFilterResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/walkInPatientFilter/walkInpatientFilterResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/walkedInPatientList/walkedInListResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyPatientFilterNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<EmergencyFilterData> emergencyFilterClass = [];

  List<EmergencyFilterData> get EmergencyFilterClass => emergencyFilterClass;

  set EmergencyFilterClass(List<EmergencyFilterData> value) {
    emergencyFilterClass = value;
    notifyListeners();
  }

  Future<void> emergencyFilter(int id, String date) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.EmergencyFilter;
    print(url);
    try {
      final input = {
        'doctor_id': id.toString(),
        'date': date.toString(),
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
          emergencyPatientFilterResponseFromJson(response.body);
      if (response.statusCode == 200) {
        print('success');
        final voucherTypeModel =
            emergencyPatientFilterResponseFromJson(response.body);
        EmergencyFilterClass = voucherTypeModel.data!;
        // log(voucherTypeModel.data![0].name.toString());
        notifyListeners();
      } else if (response.statusCode == 401) {
        print('failure');
        print('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else if (voucherTypeModel.message == " No record found ") {
        print('no data');
        EmergencyFilterClass = [];
        notifyListeners();
      } else {
        print('error');
        EmergencyFilterClass = voucherTypeModel.data!;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
