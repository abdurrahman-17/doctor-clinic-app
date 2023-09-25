// To parse this JSON data, do
//
//     final getContentMeasurementResponse = getContentMeasurementResponseFromJson(jsonString);

import 'dart:convert';

GetContentMeasurementResponse getContentMeasurementResponseFromJson(
        String str) =>
    GetContentMeasurementResponse.fromJson(json.decode(str));

String getContentMeasurementResponseToJson(
        GetContentMeasurementResponse data) =>
    json.encode(data.toJson());

class GetContentMeasurementResponse {
  GetContentMeasurementResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<ContentMeasurementData>? data;

  factory GetContentMeasurementResponse.fromJson(Map<String, dynamic> json) =>
      GetContentMeasurementResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<ContentMeasurementData>.from(
                json["data"].map((x) => ContentMeasurementData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ContentMeasurementData {
  ContentMeasurementData({
    this.id,
    this.unitName,
    this.status,
  });

  int? id;
  String? unitName;
  int? status;

  factory ContentMeasurementData.fromJson(Map<String, dynamic> json) =>
      ContentMeasurementData(
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
