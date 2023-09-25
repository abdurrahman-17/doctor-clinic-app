// To parse this JSON data, do
//
//     final editContentMeasurementResponse = editContentMeasurementResponseFromJson(jsonString);

import 'dart:convert';

EditContentMeasurementResponse editContentMeasurementResponseFromJson(
        String str) =>
    EditContentMeasurementResponse.fromJson(json.decode(str));

String editContentMeasurementResponseToJson(
        EditContentMeasurementResponse data) =>
    json.encode(data.toJson());

class EditContentMeasurementResponse {
  EditContentMeasurementResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  EditContentMeasurementData? data;

  factory EditContentMeasurementResponse.fromJson(Map<String, dynamic> json) =>
      EditContentMeasurementResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : EditContentMeasurementData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class EditContentMeasurementData {
  EditContentMeasurementData({
    this.id,
    this.unitName,
    this.status,
  });

  int? id;
  String? unitName;
  int? status;

  factory EditContentMeasurementData.fromJson(Map<String, dynamic> json) =>
      EditContentMeasurementData(
        id: json["id"] == null ? null : json["id"],
        unitName: json["unit_name"] == null ? null : json["unit_name"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "unit_name": unitName == null ? null : unitName,
        "status": status == null ? null : status,
      };
}
