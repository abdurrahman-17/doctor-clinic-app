import 'dart:developer';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/registerPatientFilter/registerPatientFilterResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/registeredPatientFilter/registeredPatientFilterResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/walkInPatientFilter/walkInpatientFilterResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPatientFilterNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<RegisterFilterData> registerFilterClass = [];

  List<RegisterFilterData> get RegisterFilterClass => registerFilterClass;

  set RegisterFilterClass(List<RegisterFilterData> value) {
    registerFilterClass = value;
    notifyListeners();
  }

  Future<void> registerFilter(String date) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.RegisterDataFilter;
    print(url);
    try {
      final input = {
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
          registerUserFilterResponseFromJson(response.body);
      if (response.statusCode == 200) {
        final voucherTypeModel =
            registerUserFilterResponseFromJson(response.body);
        RegisterFilterClass = voucherTypeModel.data!;
        // log(voucherTypeModel.data![0].name.toString());
        notifyListeners();
      } else if (response.statusCode == 401) {
        print('You are unauthorized, please login again');
        Get.offAllNamed(RoutePaths.LOGIN);
      } else if (voucherTypeModel.message == " No record found ") {
        print('no data');
        RegisterFilterClass = [];
        notifyListeners();
      } else {
        print('error');
        RegisterFilterClass = voucherTypeModel.data!;
      }
    } catch (e) {
      print(e);
    }
    isLoading = false;
  }
}
