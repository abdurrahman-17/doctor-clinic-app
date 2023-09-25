// To parse this JSON data, do
//
//     final getMedicinePrescriptionListResponse = getMedicinePrescriptionListResponseFromJson(jsonString);

import 'dart:convert';

GetMedicinePrescriptionListResponse getMedicinePrescriptionListResponseFromJson(
        String str) =>
    GetMedicinePrescriptionListResponse.fromJson(json.decode(str));

String getMedicinePrescriptionListResponseToJson(
        GetMedicinePrescriptionListResponse data) =>
    json.encode(data.toJson());

class GetMedicinePrescriptionListResponse {
  GetMedicinePrescriptionListResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<GetMedicinePrescriptionListData>? data;

  factory GetMedicinePrescriptionListResponse.fromJson(
          Map<String, dynamic> json) =>
      GetMedicinePrescriptionListResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<GetMedicinePrescriptionListData>.from(json["data"]
                .map((x) => GetMedicinePrescriptionListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetMedicinePrescriptionListData {
  GetMedicinePrescriptionListData({
    this.id,
    this.patientId,
    this.doctorId,
    this.medicineName,
    this.medicineQuantity,
    this.medicineComment,
    this.medicineFrequency,
    this.medicineTiming,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? patientId;
  int? doctorId;
  String? medicineName;
  String? medicineQuantity;
  String? medicineComment;
  String? medicineFrequency;
  String? medicineTiming;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GetMedicinePrescriptionListData.fromJson(Map<String, dynamic> json) =>
      GetMedicinePrescriptionListData(
        id: json["id"] == null ? null : json["id"],
        patientId: json["patient_id"] == null ? null : json["patient_id"],
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
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
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "patient_id": patientId == null ? null : patientId,
        "doctor_id": doctorId == null ? null : doctorId,
        "medicine_name": medicineName == null ? null : medicineName,
        "medicine_quantity": medicineQuantity == null ? null : medicineQuantity,
        "medicine_comment": medicineComment == null ? null : medicineComment,
        "medicine_frequency":
            medicineFrequency == null ? null : medicineFrequency,
        "medicine_timing": medicineTiming == null ? null : medicineTiming,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
