// To parse this JSON data, do
//
//     final doctorLeaveDeleteResponse = doctorLeaveDeleteResponseFromJson(jsonString);

import 'dart:convert';

DoctorLeaveDeleteResponse doctorLeaveDeleteResponseFromJson(String str) => DoctorLeaveDeleteResponse.fromJson(json.decode(str));

String doctorLeaveDeleteResponseToJson(DoctorLeaveDeleteResponse data) => json.encode(data.toJson());

class DoctorLeaveDeleteResponse {
  DoctorLeaveDeleteResponse({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory DoctorLeaveDeleteResponse.fromJson(Map<String, dynamic> json) => DoctorLeaveDeleteResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
