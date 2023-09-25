// To parse this JSON data, do
//
//     final deleteMedicineResponse = deleteMedicineResponseFromJson(jsonString);

import 'dart:convert';

DeleteMedicineResponse deleteMedicineResponseFromJson(String str) =>
    DeleteMedicineResponse.fromJson(json.decode(str));

String deleteMedicineResponseToJson(DeleteMedicineResponse data) =>
    json.encode(data.toJson());

class DeleteMedicineResponse {
  DeleteMedicineResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  DeleteMedicineData? data;

  factory DeleteMedicineResponse.fromJson(Map<String, dynamic> json) =>
      DeleteMedicineResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : DeleteMedicineData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class DeleteMedicineData {
  DeleteMedicineData({
    this.id,
    this.categoryId,
    this.drugName,
    this.contentMeasurement,
    this.dosage,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? categoryId;
  String? drugName;
  String? contentMeasurement;
  int? dosage;
  int? status;
  dynamic createdAt;
  DateTime? updatedAt;

  factory DeleteMedicineData.fromJson(Map<String, dynamic> json) => DeleteMedicineData(
        id: json["id"] == null ? null : json["id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        drugName: json["drug_name"] == null ? null : json["drug_name"],
        contentMeasurement: json["content_measurement"] == null
            ? null
            : json["content_measurement"],
        dosage: json["dosage"] == null ? null : json["dosage"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "category_id": categoryId == null ? null : categoryId,
        "drug_name": drugName == null ? null : drugName,
        "content_measurement":
            contentMeasurement == null ? null : contentMeasurement,
        "dosage": dosage == null ? null : dosage,
        "status": status == null ? null : status,
        "created_at": createdAt,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
