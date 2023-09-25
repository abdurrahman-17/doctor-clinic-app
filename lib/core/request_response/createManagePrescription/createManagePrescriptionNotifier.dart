import 'dart:convert';
import 'dart:developer';

import 'package:doctor_clinic_token_app/View/ManageMedicines/MedicineList/medicineList.dart';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/utils/SharedPreference/shared_preference.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'createManagePrescriptionResponse.dart';

class CreatePrescriptionTemplateNotifier extends BaseChangeNotifier {
  CreatePrescriptionTemplateResponse? createPrescriptionTemplateResponse;

  CreatePrescriptionTemplateNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> createPrescriptionTemplate(
    int doctorId,
    String clinicName,
    int clinicContact,
    String clinicAddress,
    String imageFilePath,
    String imageName,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;

    String url =
        DataConstants.LIVE_BASE_URL + DataConstants.AddPrescriptionTemplate;
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    request.fields['doctor_id'] = doctorId.toString();
    request.fields['clinic_name'] = clinicName.toString();
    request.fields['clinic_address'] = clinicAddress.toString();
    imageName.isEmpty
        ? null
        : request.files.add(await http.MultipartFile.fromPath(
            'clinic_logo', imageFilePath,
            filename: imageName));
    request.fields['clinic_contact_number'] = clinicContact.toString();
    request.headers
        .addAll({'Authorization': 'Bearer ${prefs.getString('doctorToken')}'});
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    super.isLoading = false;
    log(responsed.body);
    final createTemplateResponse = CreatePrescriptionTemplateResponse.fromJson(
        json.decode(responsed.body));
    appShowToast(createTemplateResponse.message!);
    if (responsed.statusCode == 200) {
      try {
        if (createTemplateResponse.status == true) {
          MySharedPreferences.instance.setDoctorClinicName('doctorClinicName',
              createTemplateResponse.data!.clinicName.toString());
          MySharedPreferences.instance.setDoctorClinicPrescriptionAddress(
              'doctorClinicAddress',
              createTemplateResponse.data!.clinicAddress.toString());
          MySharedPreferences.instance.setDoctorClinicContact(
              'doctorClinicContact',
              int.parse(
                  createTemplateResponse.data!.clinicContactNumber.toString()));
          MySharedPreferences.instance.setDoctorClinicLogo('doctorClinicLogo',
              createTemplateResponse.data!.clinicLogo.toString());
          MySharedPreferences.instance.setPrescriptionStatus(
              '',
              createTemplateResponse.data!.prescriptionDoctorStatus ?? 0);
          MySharedPreferences.instance.setDoctorClinicPrescriptionId(
              'doctorPrescriptionId', createTemplateResponse.data!.id ?? 0);
          Get.back();
          Get.back();
        } else
          appShowToast(createTemplateResponse.message!);
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
