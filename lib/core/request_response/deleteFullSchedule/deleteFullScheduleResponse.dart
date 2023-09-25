// To parse this JSON data, do
//
//     final deleteAllScheduleResponse = deleteAllScheduleResponseFromJson(jsonString);

import 'dart:convert';

DeleteAllScheduleResponse deleteAllScheduleResponseFromJson(String str) => DeleteAllScheduleResponse.fromJson(json.decode(str));

String deleteAllScheduleResponseToJson(DeleteAllScheduleResponse data) => json.encode(data.toJson());

class DeleteAllScheduleResponse {
  DeleteAllScheduleResponse({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory DeleteAllScheduleResponse.fromJson(Map<String, dynamic> json) => DeleteAllScheduleResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
