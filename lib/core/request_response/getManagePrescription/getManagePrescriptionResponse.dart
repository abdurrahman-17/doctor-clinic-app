// To parse this JSON data, do
//
//     final getManagePrescriptionListResponse = getManagePrescriptionListResponseFromJson(jsonString);

import 'dart:convert';

GetManagePrescriptionListResponse getManagePrescriptionListResponseFromJson(
        String str) =>
    GetManagePrescriptionListResponse.fromJson(json.decode(str));

String getManagePrescriptionListResponseToJson(
        GetManagePrescriptionListResponse data) =>
    json.encode(data.toJson());

class GetManagePrescriptionListResponse {
  GetManagePrescriptionListResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<GetPrescriptionData>? data;

  factory GetManagePrescriptionListResponse.fromJson(
          Map<String, dynamic> json) =>
      GetManagePrescriptionListResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<GetPrescriptionData>.from(
                json["data"].map((x) => GetPrescriptionData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetPrescriptionData {
  GetPrescriptionData({
    this.id,
    this.doctorId,
    this.clinicName,
    this.clinicAddress,
    this.clinicContactNumber,
    this.clinicLogo,
    this.status,
    this.prescriptionDoctorStatus,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? doctorId;
  String? clinicName;
  String? clinicAddress;
  String? clinicContactNumber;
  String? clinicLogo;
  int? status;
  int? prescriptionDoctorStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory GetPrescriptionData.fromJson(Map<String, dynamic> json) =>
      GetPrescriptionData(
        id: json["id"] == null ? null : json["id"],
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
        clinicName: json["clinic_name"] == null ? null : json["clinic_name"],
        clinicAddress:
            json["clinic_address"] == null ? null : json["clinic_address"],
        clinicContactNumber: json["clinic_contact_number"] == null
            ? null
            : json["clinic_contact_number"],
        clinicLogo: json["clinic_logo"] == null ? null : json["clinic_logo"],
        status: json["status"] == null ? null : json["status"],
        prescriptionDoctorStatus: json["prescription_doctor_status"] == null
            ? null
            : json["prescription_doctor_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "doctor_id": doctorId == null ? null : doctorId,
        "clinic_name": clinicName == null ? null : clinicName,
        "clinic_address": clinicAddress == null ? null : clinicAddress,
        "clinic_contact_number":
            clinicContactNumber == null ? null : clinicContactNumber,
        "clinic_logo": clinicLogo == null ? null : clinicLogo,
        "status": status == null ? null : status,
        "prescription_doctor_status":
            prescriptionDoctorStatus == null ? null : prescriptionDoctorStatus,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
