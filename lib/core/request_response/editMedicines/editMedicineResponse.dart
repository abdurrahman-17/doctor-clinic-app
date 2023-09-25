// To parse this JSON data, do
//
//     final editMedicineResponse = editMedicineResponseFromJson(jsonString);

import 'dart:convert';

EditMedicineResponse editMedicineResponseFromJson(String str) =>
    EditMedicineResponse.fromJson(json.decode(str));

String editMedicineResponseToJson(EditMedicineResponse data) =>
    json.encode(data.toJson());

class EditMedicineResponse {
  EditMedicineResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  EditMedicineData? data;

  factory EditMedicineResponse.fromJson(Map<String, dynamic> json) =>
      EditMedicineResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : EditMedicineData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class EditMedicineData {
  EditMedicineData({
    this.id,
    this.categoryId,
    this.drugName,
    this.contentMeasurement,
    this.dosage,
    this.status,
  });

  int? id;
  String? categoryId;
  String? drugName;
  String? contentMeasurement;
  String? dosage;
  int? status;

  factory EditMedicineData.fromJson(Map<String, dynamic> json) =>
      EditMedicineData(
        id: json["id"] == null ? null : json["id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        drugName: json["drug_name"] == null ? null : json["drug_name"],
        contentMeasurement: json["content_measurement"] == null
            ? null
            : json["content_measurement"],
        dosage: json["dosage"] == null ? null : json["dosage"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "category_id": categoryId == null ? null : categoryId,
        "drug_name": drugName == null ? null : drugName,
        "content_measurement":
            contentMeasurement == null ? null : contentMeasurement,
        "dosage": dosage == null ? null : dosage,
        "status": status == null ? null : status,
      };
}
