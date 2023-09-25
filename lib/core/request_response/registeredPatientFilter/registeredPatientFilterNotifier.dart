import 'dart:developer';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/registeredPatientFilter/registeredPatientFilterResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/walkInPatientFilter/walkInpatientFilterResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisteredPatientFilterNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<RegisteredFilterData> registeredFilterClass = [];

  List<RegisteredFilterData> get RegisteredFilterClass => registeredFilterClass;

  set RegisteredFilterClass(List<RegisteredFilterData> value) {
    registeredFilterClass = value;
    notifyListeners();
  }

  Future<void> registeredFilter(int id, String date) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.RegisteredFilter;
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
          registeredPatientFilterResponseFromJson(response.body);
      if (response.statusCode == 200) {
        final voucherTypeModel =
            registeredPatientFilterResponseFromJson(response.body);
        RegisteredFilterClass = voucherTypeModel.data!;
        // log(voucherTypeModel.data![0].name.toString());
        notifyListeners();
      } else if (response.statusCode == 401) {
        print('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else if (voucherTypeModel.message == " No record found ") {
        print('no data');
        RegisteredFilterClass = [];
        notifyListeners();
      } else {
        print('error');
        RegisteredFilterClass = voucherTypeModel.data!;
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
