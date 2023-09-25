import 'dart:developer';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/privacyPolicy/privacyPolicyResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyPolicyNotifier extends BaseChangeNotifier {
  bool isloading = false;

  List<PrivacyPolicyContent> privacyPolicyClass = [];
  List<PrivacyPolicyContent> get PrivacyPolicyClass => [];

  set PrivacyPolicyClass(List<PrivacyPolicyContent> value) {
    privacyPolicyClass = value;
    notifyListeners();
  }

  Future<void> privacyPolicy(int doctorId) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.PrivacyPolicy;
    print(url);
    try {
      final input = {'clinic_doc_id': doctorId.toString()};
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
        final appointmentModel = privayPolicyResponseFromJson(response.body);
        PrivacyPolicyClass = appointmentModel.privacyPolicyContent!;
        //print(About_Us_Class.privacyPolicy.toString());
        //TermsAndConditions_Date_Class = appointmentModel.date!;
        //log(appointmentModel.data![0].doctorName.toString());
        notifyListeners();
      } else if (response.statusCode == 401) {
        appShowToast('You are unauthorized, please login again');
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
