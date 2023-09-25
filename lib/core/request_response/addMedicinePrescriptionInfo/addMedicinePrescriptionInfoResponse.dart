// To parse this JSON data, do
//
//     final addMedicinePrescriptionInfoResponse = addMedicinePrescriptionInfoResponseFromJson(jsonString);

import 'dart:convert';

AddMedicinePrescriptionInfoResponse addMedicinePrescriptionInfoResponseFromJson(
        String str) =>
    AddMedicinePrescriptionInfoResponse.fromJson(json.decode(str));

String addMedicinePrescriptionInfoResponseToJson(
        AddMedicinePrescriptionInfoResponse data) =>
    json.encode(data.toJson());

class AddMedicinePrescriptionInfoResponse {
  AddMedicinePrescriptionInfoResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  MedicinePrescriptionInfoData? data;

  factory AddMedicinePrescriptionInfoResponse.fromJson(
          Map<String, dynamic> json) =>
      AddMedicinePrescriptionInfoResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : MedicinePrescriptionInfoData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class MedicinePrescriptionInfoData {
  MedicinePrescriptionInfoData({
    this.medicineName,
    this.medicineQuantity,
    this.medicineComment,
    this.medicineFrequency,
    this.medicineTiming,
    this.patientId,
    this.doctorId,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String? medicineName;
  String? medicineQuantity;
  String? medicineComment;
  String? medicineFrequency;
  String? medicineTiming;
  String? patientId;
  String? doctorId;
  int? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  factory MedicinePrescriptionInfoData.fromJson(Map<String, dynamic> json) =>
      MedicinePrescriptionInfoData(
        medicineName:
            json["medicine_name"] == null ? null : json["medicine_name"],
        medicineQuantity: json["medicine_quantity"] == null
            ? null
            : json["medicine_quantity"],
        medicineComment:
            json["medicine_comment"] == null ? null : json["medicine_comment"],
        medicineFrequency: json["medicine_frequency"] == null
            ? null
            : json["medicine_frequency"],
        medicineTiming:
            json["medicine_timing"] == null ? null : json["medicine_timing"],
        patientId: json["patient_id"] == null ? null : json["patient_id"],
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
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
        "medicine_name": medicineName == null ? null : medicineName,
        "medicine_quantity": medicineQuantity == null ? null : medicineQuantity,
        "medicine_comment": medicineComment == null ? null : medicineComment,
        "medicine_frequency":
            medicineFrequency == null ? null : medicineFrequency,
        "medicine_timing": medicineTiming == null ? null : medicineTiming,
        "patient_id": patientId == null ? null : patientId,
        "doctor_id": doctorId == null ? null : doctorId,
        "status": status == null ? null : status,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "id": id == null ? null : id,
      };
}
