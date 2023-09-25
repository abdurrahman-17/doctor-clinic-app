import 'dart:developer';

import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/staffList/stafflistResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StaffListNotifier extends BaseChangeNotifier {
  // final SharedPref _prefs = locator.get<SharedPref>();
  bool isloading = false;
  List<StaffListData> staffListClass = [];
  List<StaffListData> staffSearchClass = [];

  List<StaffListData> get StaffListClass => staffListClass;

  set StaffListClass(List<StaffListData> value) {
    staffListClass = value;
    notifyListeners();
  }

  Future<void> staffList(int doctorId, String id, String loginStatus) async {
    final prefs = await SharedPreferences.getInstance();
    isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.StaffList;
    print(url);

    try {
      final input = {
        'doctor_id': doctorId.toString(),
      };
      final statusInput = {
        'doctor_id': doctorId.toString(),
        'staff_id': id.toString() ,
        'status': loginStatus.toString(),
      };
      print(input);
      print(statusInput);
      final response = await http.post(
        Uri.parse(url),
        body: loginStatus == 'null' ? input : statusInput,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
          'Accept': 'application/json'
        },
      );
      log(response.body);
      final voucherTypeModel = staffListResponseFromJson(response.body);
      if (response.statusCode == 200) {
        final voucherTypeModel = staffListResponseFromJson(response.body);
        StaffListClass = voucherTypeModel.data!;
        staffSearchClass = StaffListClass;
        appShowToast(voucherTypeModel.message!);
        // log(voucherTypeModel.data![0].name.toString());
        notifyListeners();
      } else if (response.statusCode == 401) {
        print('You are unauthorized, please login again');
        appShowToast(voucherTypeModel.message!);
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
