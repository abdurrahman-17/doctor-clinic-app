// To parse this JSON data, do
//
//     final doctorLeaveConfirmResponse = doctorLeaveConfirmResponseFromJson(jsonString);

import 'dart:convert';

DoctorLeaveConfirmResponse doctorLeaveConfirmResponseFromJson(String str) => DoctorLeaveConfirmResponse.fromJson(json.decode(str));

String doctorLeaveConfirmResponseToJson(DoctorLeaveConfirmResponse data) => json.encode(data.toJson());

class DoctorLeaveConfirmResponse {
  DoctorLeaveConfirmResponse({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory DoctorLeaveConfirmResponse.fromJson(Map<String, dynamic> json) => DoctorLeaveConfirmResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
