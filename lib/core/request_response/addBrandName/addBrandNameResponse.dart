// To parse this JSON data, do
//
//     final addBrandNameResponse = addBrandNameResponseFromJson(jsonString);

import 'dart:convert';

AddBrandNameResponse addBrandNameResponseFromJson(String str) =>
    AddBrandNameResponse.fromJson(json.decode(str));

String addBrandNameResponseToJson(AddBrandNameResponse data) =>
    json.encode(data.toJson());

class AddBrandNameResponse {
  AddBrandNameResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  AddBrandNameData? data;

  factory AddBrandNameResponse.fromJson(Map<String, dynamic> json) =>
      AddBrandNameResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : AddBrandNameData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class AddBrandNameData {
  AddBrandNameData({
    this.medicineBrandName,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? medicineBrandName;
  int? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory AddBrandNameData.fromJson(Map<String, dynamic> json) =>
      AddBrandNameData(
        medicineBrandName: json["medicine_brand_name"] == null
            ? null
            : json["medicine_brand_name"],
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
        "medicine_brand_name":
            medicineBrandName == null ? null : medicineBrandName,
        "status": status == null ? null : status,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "id": id == null ? null : id,
      };
}
