// To parse this JSON data, do
//
//     final editCategoryResponse = editCategoryResponseFromJson(jsonString);

import 'dart:convert';

EditCategoryResponse editCategoryResponseFromJson(String str) =>
    EditCategoryResponse.fromJson(json.decode(str));

String editCategoryResponseToJson(EditCategoryResponse data) =>
    json.encode(data.toJson());

class EditCategoryResponse {
  EditCategoryResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  EditCategoryData? data;

  factory EditCategoryResponse.fromJson(Map<String, dynamic> json) =>
      EditCategoryResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : EditCategoryData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class EditCategoryData {
  EditCategoryData({
    this.id,
    this.categoryName,
    this.status,
  });

  int? id;
  String? categoryName;
  int? status;

  factory EditCategoryData.fromJson(Map<String, dynamic> json) =>
      EditCategoryData(
        id: json["id"] == null ? null : json["id"],
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "category_name": categoryName == null ? null : categoryName,
        "status": status == null ? null : status,
      };
}
