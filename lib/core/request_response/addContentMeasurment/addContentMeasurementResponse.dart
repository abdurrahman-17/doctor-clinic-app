// To parse this JSON data, do
//
//     final addContentMeasurementResponse = addContentMeasurementResponseFromJson(jsonString);

import 'dart:convert';

AddContentMeasurementResponse addContentMeasurementResponseFromJson(
        String str) =>
    AddContentMeasurementResponse.fromJson(json.decode(str));

String addContentMeasurementResponseToJson(
        AddContentMeasurementResponse data) =>
    json.encode(data.toJson());

class AddContentMeasurementResponse {
  AddContentMeasurementResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory AddContentMeasurementResponse.fromJson(Map<String, dynamic> json) =>
      AddContentMeasurementResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.unitName,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? unitName;
  int? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        unitName: json["unit_name"] == null ? null : json["unit_name"],
        status: json["status"] == null ? null : json["status"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "unit_name": unitName == null ? null : unitName,
        "status": status == null ? null : status,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "id": id == null ? null : id,
      };
}
