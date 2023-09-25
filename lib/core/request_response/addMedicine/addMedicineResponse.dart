// To parse this JSON data, do
//
//     final addMedicineResponse = addMedicineResponseFromJson(jsonString);

import 'dart:convert';

AddMedicineResponse addMedicineResponseFromJson(String str) =>
    AddMedicineResponse.fromJson(json.decode(str));

String addMedicineResponseToJson(AddMedicineResponse data) =>
    json.encode(data.toJson());

class AddMedicineResponse {
  AddMedicineResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  AddMedicineData? data;

  factory AddMedicineResponse.fromJson(Map<String, dynamic> json) =>
      AddMedicineResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : AddMedicineData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class AddMedicineData {
  AddMedicineData({
    this.drugName,
    this.categoryId,
    this.contentMeasurement,
    this.dosage,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? drugName;
  String? categoryId;
  String? contentMeasurement;
  String? dosage;
  int? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory AddMedicineData.fromJson(Map<String, dynamic> json) =>
      AddMedicineData(
        drugName: json["drug_name"] == null ? null : json["drug_name"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        contentMeasurement: json["content_measurement"] == null
            ? null
            : json["content_measurement"],
        dosage: json["dosage"] == null ? null : json["dosage"],
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
        "drug_name": drugName == null ? null : drugName,
        "category_id": categoryId == null ? null : categoryId,
        "content_measurement":
            contentMeasurement == null ? null : contentMeasurement,
        "dosage": dosage == null ? null : dosage,
        "status": status == null ? null : status,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "id": id == null ? null : id,
      };
}
