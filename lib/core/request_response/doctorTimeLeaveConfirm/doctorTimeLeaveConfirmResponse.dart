// To parse this JSON data, do
//
//     final doctorLeaveConfirmResponse = doctorLeaveConfirmResponseFromJson(jsonString);

import 'dart:convert';

DoctorTimeLeaveConfirmResponse doctorTimeLeaveConfirmResponseFromJson(String str) => DoctorTimeLeaveConfirmResponse.fromJson(json.decode(str));

String doctorTimeLeaveConfirmResponseToJson(DoctorTimeLeaveConfirmResponse data) => json.encode(data.toJson());

class DoctorTimeLeaveConfirmResponse {
  DoctorTimeLeaveConfirmResponse({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory DoctorTimeLeaveConfirmResponse.fromJson(Map<String, dynamic> json) => DoctorTimeLeaveConfirmResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
