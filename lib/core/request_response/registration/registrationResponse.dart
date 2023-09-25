// To parse this JSON data, do
//
//     final rigistrationResponse = rigistrationResponseFromJson(jsonString);

import 'dart:convert';

RigistrationResponse rigistrationResponseFromJson(String str) =>
    RigistrationResponse.fromJson(json.decode(str));

String rigistrationResponseToJson(RigistrationResponse data) =>
    json.encode(data.toJson());

class RigistrationResponse {
  RigistrationResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  RegistrationData? data;

  factory RigistrationResponse.fromJson(Map<String, dynamic> json) =>
      RigistrationResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : RegistrationData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class RegistrationData {
  RegistrationData({
    this.name,
    this.email,
    this.about,
    this.androidToken,
    this.experience,
    this.specialist,
    this.patientAttend,
    this.degree,
    this.phone,
    this.address,
    this.clinicAddress,
    this.image,
    this.city,
    this.state,
    this.type,
    this.zipCode,
    this.prescriptionDoctorStatus,
    this.id,
  });

  String? name;
  String? email;
  String? about;
  dynamic androidToken;
  String? experience;
  String? specialist;
  String? patientAttend;
  String? degree;
  String? phone;
  String? address;
  String? clinicAddress;
  String? image;
  String? city;
  String? state;
  String? type;
  String? zipCode;
  int? prescriptionDoctorStatus;
  int? id;

  factory RegistrationData.fromJson(Map<String, dynamic> json) =>
      RegistrationData(
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        about: json["about"] == null ? null : json["about"],
        androidToken: json["android_token"],
        experience: json["experience"] == null ? null : json["experience"],
        specialist: json["specialist"] == null ? null : json["specialist"],
        patientAttend:
            json["patient_attend"] == null ? null : json["patient_attend"],
        degree: json["degree"] == null ? null : json["degree"],
        phone: json["phone"] == null ? null : json["phone"],
        address: json["address"] == null ? null : json["address"],
        clinicAddress:
            json["clinic_address"] == null ? null : json["clinic_address"],
        image: json["image"] == null ? null : json["image"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        type: json["type"] == null ? null : json["type"],
        zipCode: json["zip_code"] == null ? null : json["zip_code"],
        prescriptionDoctorStatus: json["prescription_doctor_status"] == null
            ? null
            : json["prescription_doctor_status"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "about": about == null ? null : about,
        "android_token": androidToken,
        "experience": experience == null ? null : experience,
        "specialist": specialist == null ? null : specialist,
        "patient_attend": patientAttend == null ? null : patientAttend,
        "degree": degree == null ? null : degree,
        "phone": phone == null ? null : phone,
        "address": address == null ? null : address,
        "clinic_address": clinicAddress == null ? null : clinicAddress,
        "image": image == null ? null : image,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "type": type == null ? null : type,
        "zip_code": zipCode == null ? null : zipCode,
        "prescription_doctor_status":
            prescriptionDoctorStatus == null ? null : prescriptionDoctorStatus,
        "id": id == null ? null : id,
      };
}
