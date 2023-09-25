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

import 'editManagePrescriptionResponse.dart';

class EditPrescriptionTemplateNotifier extends BaseChangeNotifier {
  EditPrescriptionTemplateResponse? editPrescriptionTemplateResponse;

  EditPrescriptionTemplateNotifier() {
    //Get Device Information
    //getHardwareDeviceInfo();
  }

  Future<void> editPrescriptionTemplate(
    int doctorId,
    String clinicName,
    int clinicContact,
    String clinicAddress,
    String imageFilePath,
    String imageName,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;

    print(clinicName);
    print(clinicContact);
    print(clinicAddress);
    print(clinicName);
    print(doctorId);
    String url =
        DataConstants.LIVE_BASE_URL + DataConstants.EditPrescriptionTemplate;
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    request.fields['prescription_theme_id'] = doctorId.toString();
    request.fields['clinic_name'] = clinicName.toString();
    request.fields['clinic_address'] = clinicAddress.toString();
    imageFilePath == "null"
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
    final editTemplateResponse =
        EditPrescriptionTemplateResponse.fromJson(json.decode(responsed.body));
    appShowToast(editTemplateResponse.message!);
    if (responsed.statusCode == 200) {
      try {
        if (editTemplateResponse.status == true) {
          MySharedPreferences.instance.setDoctorClinicName('doctorClinicName',
              editTemplateResponse.data!.clinicName.toString());
          MySharedPreferences.instance.setDoctorClinicPrescriptionAddress(
              'doctorClinicAddress',
              editTemplateResponse.data!.clinicAddress.toString());
          MySharedPreferences.instance.setDoctorClinicContact(
              'doctorClinicContact',
              int.parse(
                  editTemplateResponse.data!.clinicContactNumber.toString()));
          MySharedPreferences.instance.setDoctorClinicLogo('doctorClinicLogo',
              editTemplateResponse.data!.clinicLogo.toString());
          Get.back();
          Get.back();
        } else
          appShowToast(editTemplateResponse.message!);
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
