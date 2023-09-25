// To parse this JSON data, do
//
//     final getMedicineCategoryResponse = getMedicineCategoryResponseFromJson(jsonString);

import 'dart:convert';

GetMedicineCategoryResponse getMedicineCategoryResponseFromJson(String str) =>
    GetMedicineCategoryResponse.fromJson(json.decode(str));

String getMedicineCategoryResponseToJson(GetMedicineCategoryResponse data) =>
    json.encode(data.toJson());

class GetMedicineCategoryResponse {
  GetMedicineCategoryResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<MedicineCategoryData>? data;

  factory GetMedicineCategoryResponse.fromJson(Map<String, dynamic> json) =>
      GetMedicineCategoryResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<MedicineCategoryData>.from(
                json["data"].map((x) => MedicineCategoryData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MedicineCategoryData {
  MedicineCategoryData({
    this.id,
    this.categoryName,
    this.status,
  });

  int? id;
  String? categoryName;
  int? status;

  factory MedicineCategoryData.fromJson(Map<String, dynamic> json) =>
      MedicineCategoryData(
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
