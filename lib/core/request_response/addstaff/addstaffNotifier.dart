import 'dart:convert';
import 'dart:developer';
import 'package:doctor_clinic_token_app/core/base/base_change_notifier.dart';
import 'package:doctor_clinic_token_app/core/data_constants.dart';
import 'package:doctor_clinic_token_app/core/request_response/adddoctor/adddoctorResponse.dart';
import 'package:doctor_clinic_token_app/core/request_response/addstaff/addstaffResponse.dart';
import 'package:doctor_clinic_token_app/utils/common/app_message.dart';
import 'package:doctor_clinic_token_app/utils/common/app_route_paths.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddStaffNotifier extends BaseChangeNotifier {
  AddStaffResponse? addStaffResponse;

  AddStaffNotifier() {}

  Future<void> addStaffInfo(
    int doctorId,
    String name,
    String email,
    String password,
    String imageFilePath,
    String imageName,
    int mobileNumber,
    String address,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    super.isLoading = true;

    final input = {
      'doctor_id': doctorId.toString(),
      'from_date': name,
      'to_date': email,
      'from_time': password,
      'to_time': mobileNumber,
    };
    print(input);

    String url = DataConstants.LIVE_BASE_URL + DataConstants.AddStaff;
    print(url);
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    request.fields['doctor_id'] = doctorId.toString();
    request.fields['name'] = name.toString();
    request.fields['email'] = email.toString();
    request.fields['password'] = password.toString();
    imageName.isEmpty
        ? null
        : request.files.add(await http.MultipartFile.fromPath(
            'image', imageFilePath,
            filename: imageName));
    request.fields['phone'] = mobileNumber.toString();
    request.fields['address'] = address.toString();

    request.headers
        .addAll({'Authorization': 'Bearer ${prefs.getString('doctorToken')}'});
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);

    super.isLoading = false;
    log(responsed.body);
    final addStaffInfoResponse =
        AddStaffResponse.fromJson(json.decode(responsed.body));
    appShowToast(addStaffInfoResponse.message!);
    if (responsed.statusCode == 200) {
      try {
        if (addStaffInfoResponse.status == true) {
          Get.back();
          Get.offAndToNamed(RoutePaths.StaffList, arguments: true);
        } else
          appShowToast(addStaffInfoResponse.message!);
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
