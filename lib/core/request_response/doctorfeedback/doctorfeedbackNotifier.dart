import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doctor_clinic_token_app/View/ListOfAppointment/listOfAppointment.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorfeedback/doctorfeedbackResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DoctorFeedbackNotifier extends BaseChangeNotifier {
  DoctorFeedBackResponse? doctorFeedBackResponse;

  DoctorFeedbackNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> doctorFeedback(
    int patientID,
    String feedBack,
    List images,
    List fileName,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.DoctorFeedBack;
    print(url);
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    request.fields['appoinment_id'] = patientID.toString();
    request.fields['feedback'] = feedBack.toString();
    // request.fields['prescription[]'] = images.toString();

    List<http.MultipartFile> newList = [];

    for (int i = 0; i < images.length; i++) {
      var path = await images[i];
      File imageFile = File(path);

      var stream = http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();

      var multipartFile = http.MultipartFile("prescription[]", stream, length,
          filename: fileName[i]);
      newList.add(multipartFile);
    }
    request.files.addAll(newList);

    request.headers
        .addAll({'Authorization': 'Bearer ${prefs.getString('doctorToken')}'});
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    print(response);

    super.isLoading = false;
    log(responsed.body);
    if (response.statusCode == 200) {
      print('Irafan');
      try {
        final addDoctorFeedbackInfoResponse =
            DoctorFeedBackResponse.fromJson(json.decode(responsed.body));
        if (addDoctorFeedbackInfoResponse.status == true) {
          print('Niceeeee');
          Get.back();
          Get.back();
          Get.to(ListOfAppointment(selectedPage: 2));
        } else
          appShowToast(addDoctorFeedbackInfoResponse.message!);
      } catch (e) {
        print(e);
        appShowToast(e.toString());
      }
    } else if (response.statusCode == 401) {
      appShowToast('You are unauthorized, please login again');
      Get.offAllNamed(RoutePaths.LOGIN);
    }
  }
}
