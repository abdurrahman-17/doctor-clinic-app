// To parse this JSON data, do
//
//     final prescriptionUpdateResponse = prescriptionUpdateResponseFromJson(jsonString);

import 'dart:convert';

PrescriptionUpdateResponse prescriptionUpdateResponseFromJson(String str) => PrescriptionUpdateResponse.fromJson(json.decode(str));

String prescriptionUpdateResponseToJson(PrescriptionUpdateResponse data) => json.encode(data.toJson());

class PrescriptionUpdateResponse {
  PrescriptionUpdateResponse({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory PrescriptionUpdateResponse.fromJson(Map<String, dynamic> json) => PrescriptionUpdateResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
