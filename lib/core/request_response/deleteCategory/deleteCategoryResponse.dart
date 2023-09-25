// To parse this JSON data, do
//
//     final deleteCategoryResponse = deleteCategoryResponseFromJson(jsonString);

import 'dart:convert';

DeleteCategoryResponse deleteCategoryResponseFromJson(String str) =>
    DeleteCategoryResponse.fromJson(json.decode(str));

String deleteCategoryResponseToJson(DeleteCategoryResponse data) =>
    json.encode(data.toJson());

class DeleteCategoryResponse {
  DeleteCategoryResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  DeleteCategoryData? data;

  factory DeleteCategoryResponse.fromJson(Map<String, dynamic> json) =>
      DeleteCategoryResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : DeleteCategoryData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class DeleteCategoryData {
  DeleteCategoryData({
    this.id,
    this.categoryName,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? categoryName;
  dynamic image;
  int? status;
  dynamic createdAt;
  DateTime? updatedAt;

  factory DeleteCategoryData.fromJson(Map<String, dynamic> json) =>
      DeleteCategoryData(
        id: json["id"] == null ? null : json["id"],
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
        image: json["image"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "category_name": categoryName == null ? null : categoryName,
        "image": image,
        "status": status == null ? null : status,
        "created_at": createdAt,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
