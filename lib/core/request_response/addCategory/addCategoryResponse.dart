// To parse this JSON data, do
//
//     final addCategoryResponse = addCategoryResponseFromJson(jsonString);

import 'dart:convert';

AddCategoryResponse addCategoryResponseFromJson(String str) =>
    AddCategoryResponse.fromJson(json.decode(str));

String addCategoryResponseToJson(AddCategoryResponse data) =>
    json.encode(data.toJson());

class AddCategoryResponse {
  AddCategoryResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  AddCategoryData? data;

  factory AddCategoryResponse.fromJson(Map<String, dynamic> json) =>
      AddCategoryResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : AddCategoryData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class AddCategoryData {
  AddCategoryData({
    this.categoryName,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? categoryName;
  int? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory AddCategoryData.fromJson(Map<String, dynamic> json) =>
      AddCategoryData(
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
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
        "category_name": categoryName == null ? null : categoryName,
        "status": status == null ? null : status,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "id": id == null ? null : id,
      };
}
