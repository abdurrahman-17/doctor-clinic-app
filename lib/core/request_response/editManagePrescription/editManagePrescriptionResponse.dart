// To parse this JSON data, do
//
//     final editPrescriptionTemplateResponse = editPrescriptionTemplateResponseFromJson(jsonString);

import 'dart:convert';

EditPrescriptionTemplateResponse editPrescriptionTemplateResponseFromJson(
        String str) =>
    EditPrescriptionTemplateResponse.fromJson(json.decode(str));

String editPrescriptionTemplateResponseToJson(
        EditPrescriptionTemplateResponse data) =>
    json.encode(data.toJson());

class EditPrescriptionTemplateResponse {
  EditPrescriptionTemplateResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  EditPrescriptionTemplateData? data;

  factory EditPrescriptionTemplateResponse.fromJson(
          Map<String, dynamic> json) =>
      EditPrescriptionTemplateResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : EditPrescriptionTemplateData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class EditPrescriptionTemplateData {
  EditPrescriptionTemplateData({
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
  int? doctorId;
  int? status;
  int? prescriptionDoctorStatus;
  int? id;

  factory EditPrescriptionTemplateData.fromJson(Map<String, dynamic> json) =>
      EditPrescriptionTemplateData(
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
