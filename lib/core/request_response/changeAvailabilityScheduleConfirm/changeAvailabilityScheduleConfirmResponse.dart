// To parse this JSON data, do
//
//     final changeAvailabilityScheduleConfirmResponse = changeAvailabilityScheduleConfirmResponseFromJson(jsonString);

import 'dart:convert';

ChangeAvailabilityScheduleConfirmResponse changeAvailabilityScheduleConfirmResponseFromJson(String str) => ChangeAvailabilityScheduleConfirmResponse.fromJson(json.decode(str));

String changeAvailabilityScheduleConfirmResponseToJson(ChangeAvailabilityScheduleConfirmResponse data) => json.encode(data.toJson());

class ChangeAvailabilityScheduleConfirmResponse {
  ChangeAvailabilityScheduleConfirmResponse({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory ChangeAvailabilityScheduleConfirmResponse.fromJson(Map<String, dynamic> json) => ChangeAvailabilityScheduleConfirmResponse(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
