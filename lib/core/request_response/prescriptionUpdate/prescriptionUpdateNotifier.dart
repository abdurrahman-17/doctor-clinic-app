import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doctor_clinic_token_app/View/ListOfAppointment/listOfAppointment.dart';
import 'package:doctor_clinic_token_app/View/Patient%20Data/appointment.dart';
import 'package:doctor_clinic_token_app/View/Patient%20Data/patient_data.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/addPatientInfo/addpatientinfoResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/doctorfeedback/doctorfeedbackResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/prescriptionUpdate/prescriptionUpdateResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class PrescriptionUpdateNotifier extends BaseChangeNotifier {

  PrescriptionUpdateNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> prescriptionUpdate(
      int appointmentId,
      String apiImage,
      List images,
      List fileName,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;
    String url = DataConstants.LIVE_BASE_URL + DataConstants.PrescriptionUpdate;
    print(url);
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    request.fields['appointment_id'] = appointmentId.toString();
    request.fields['old_prescription'] = apiImage.toString();

    // request.fields['prescription[]'] = images.toString();

    List<http.MultipartFile> newList = [];

    for (int i = 0; i < images.length; i++) {
      var path = await images[i];
      File imageFile =  File(path);

      var stream =  http.ByteStream(imageFile.openRead());
      var length = await imageFile.length();

      var multipartFile =  http.MultipartFile("prescription[]", stream, length,
          filename: fileName[i]);
      newList.add(multipartFile);
    }
    request.files.addAll(newList);

    request.headers.addAll({'Authorization': 'Bearer ${prefs.getString('doctorToken')}'});
    var response=await request.send();
    var responsed=await http.Response.fromStream(response);
    log(responsed.toString());

    super.isLoading = false;
    log(responsed.body);
    print(responsed.statusCode);
    if (responsed.statusCode == 200) {
      print('Hello');
      try {
        print('Why');
        final addPrecription = PrescriptionUpdateResponse.fromJson(json.decode(responsed.body));
        if (addPrecription.status == true) {
          print('No');
          Get.back();
          Get.back();
          Get.to(ListOfAppointment(selectedPage: 2));
        } else
          appShowToast(addPrecription.message!);
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
