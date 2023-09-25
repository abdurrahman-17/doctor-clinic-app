// To parse this JSON data, do
//
//     final deleteContentMeasurementResponse = deleteContentMeasurementResponseFromJson(jsonString);

import 'dart:convert';

DeleteContentMeasurementResponse deleteContentMeasurementResponseFromJson(
        String str) =>
    DeleteContentMeasurementResponse.fromJson(json.decode(str));

String deleteContentMeasurementResponseToJson(
        DeleteContentMeasurementResponse data) =>
    json.encode(data.toJson());

class DeleteContentMeasurementResponse {
  DeleteContentMeasurementResponse({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory DeleteContentMeasurementResponse.fromJson(
          Map<String, dynamic> json) =>
      DeleteContentMeasurementResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
      };
}
