import 'dart:developer';

import 'package:doctor_clinic_token_app/View/AbouUs/aboutUs.dart';
import 'package:doctor_clinic_token_app/View/TermsCondition/termsAndCondition.dart';
import 'package:doctor_clinic_token_app/View/privacyPolicy/privacyPolicy.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/updatePolicy/updatePolicyResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePolicyNotifier extends BaseChangeNotifier {
  bool isloading = false;

  UpdatePolicyData privacyPolicyClass = UpdatePolicyData();

  UpdatePolicyData get PrivacyPolicyClass => UpdatePolicyData();

  set PrivacyPolicyClass(UpdatePolicyData value) {
    privacyPolicyClass = value;
    notifyListeners();
  }

  Future<void> updatePolicy(int doctorId, int id, String privacyPolicy,
      String aboutUs, String termsAndCondition) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.UpdatePolicy;
    print(url);
    try {
      final inputP = {
        'doctor_id': doctorId.toString(),
        'id': id.toString(),
        'clinic_privacy_policy': privacyPolicy.toString(),
      };

      final inputT = {
        'doctor_id': doctorId.toString(),
        'id': id.toString(),
        'clinic_terms_and_condition': termsAndCondition.toString(),
      };

      final inputA = {
        'doctor_id': doctorId.toString(),
        'id': id.toString(),
        'clinic_about_us': aboutUs.toString(),
      };
      // print(inputA);
      final response = await http.post(
        Uri.parse(url),
        body: aboutUs != "null"
            ? inputA
            : termsAndCondition != "null"
                ? inputT
                : privacyPolicy != "null"
                    ? inputP
                    : inputP,
        headers: {
          'Authorization': 'Bearer ${prefs.getString('doctorToken')}',
          'Accept': 'application/json'
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        final appointmentModel = updatePolicyResponseFromJson(response.body);
        PrivacyPolicyClass = appointmentModel.data!;
        Get.back();
        Get.back();
        aboutUs != "null"
            ? Get.to(AboutUs())
            : termsAndCondition != "null"
                ? Get.to(Terms_And_Condition())
                : privacyPolicy != "null"
                    ? Get.to(Privacy_Policy())
                    : Get.to(Privacy_Policy());
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
