// To parse this JSON data, do
//
//     final createPrescriptionTemplateResponse = createPrescriptionTemplateResponseFromJson(jsonString);

import 'dart:convert';

CreatePrescriptionTemplateResponse createPrescriptionTemplateResponseFromJson(
        String str) =>
    CreatePrescriptionTemplateResponse.fromJson(json.decode(str));

String createPrescriptionTemplateResponseToJson(
        CreatePrescriptionTemplateResponse data) =>
    json.encode(data.toJson());

class CreatePrescriptionTemplateResponse {
  CreatePrescriptionTemplateResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  PrescriptionTemplateData? data;

  factory CreatePrescriptionTemplateResponse.fromJson(
          Map<String, dynamic> json) =>
      CreatePrescriptionTemplateResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : PrescriptionTemplateData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class PrescriptionTemplateData {
  PrescriptionTemplateData({
    this.clinicName,
    this.clinicAddress,
    this.clinicContactNumber,
    this.clinicLogo,
    this.doctorId,
    this.status,
    this.prescriptionDoctorStatus,
    this.id,
  });

  String? clinicName;
  String? clinicAddress;
  String? clinicContactNumber;
  String? clinicLogo;
  String? doctorId;
  int? status;
  int? prescriptionDoctorStatus;
  int? id;

  factory PrescriptionTemplateData.fromJson(Map<String, dynamic> json) =>
      PrescriptionTemplateData(
        clinicName: json["clinic_name"] == null ? null : json["clinic_name"],
        clinicAddress:
            json["clinic_address"] == null ? null : json["clinic_address"],
        clinicContactNumber: json["clinic_contact_number"] == null
            ? null
            : json["clinic_contact_number"],
        clinicLogo: json["clinic_logo"] == null ? null : json["clinic_logo"],
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
        status: json["status"] == null ? null : json["status"],
        prescriptionDoctorStatus: json["prescription_doctor_status"] == null
            ? null
            : json["prescription_doctor_status"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "clinic_name": clinicName == null ? null : clinicName,
        "clinic_address": clinicAddress == null ? null : clinicAddress,
        "clinic_contact_number":
            clinicContactNumber == null ? null : clinicContactNumber,
        "clinic_logo": clinicLogo == null ? null : clinicLogo,
        "doctor_id": doctorId == null ? null : doctorId,
        "status": status == null ? null : status,
        "prescription_doctor_status":
            prescriptionDoctorStatus == null ? null : prescriptionDoctorStatus,
        "id": id == null ? null : id,
      };
}
