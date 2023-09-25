import 'dart:developer';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/termsAndCondition/termsAndConditionResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TermsAndCondition_Notifier extends BaseChangeNotifier {
  bool isloading = false;

  List<TermsAndConditionData> termsAndConditions_ResponseClass = [];
  List<TermsAndConditionData> get TermsAndConditions_Class => [];

  set TermsAndConditions_Class(List<TermsAndConditionData> value) {
    termsAndConditions_ResponseClass = value;
    notifyListeners();
  }

  Future<void> TermsAndConditions_data(int doctorId) async {
    isLoading = true;
    final prefs = await SharedPreferences.getInstance();
    String url = DataConstants.LIVE_BASE_URL + DataConstants.TermsAndCondition;
    print(url);
    try {
      final input = {'clinic_doc_id': doctorId.toString()};
      //print(input);
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
        final appointmentModel =
            termsAndConditionResponseFromJson(response.body);
        TermsAndConditions_Class = appointmentModel.data!;
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
