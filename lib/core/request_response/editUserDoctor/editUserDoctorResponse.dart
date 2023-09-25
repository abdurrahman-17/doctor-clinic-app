// To parse this JSON data, do
//
//     final editUserDoctorResponse = editUserDoctorResponseFromJson(jsonString);

import 'dart:convert';

EditUserDoctorResponse editUserDoctorResponseFromJson(String str) =>
    EditUserDoctorResponse.fromJson(json.decode(str));

String editUserDoctorResponseToJson(EditUserDoctorResponse data) =>
    json.encode(data.toJson());

class EditUserDoctorResponse {
  EditUserDoctorResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  EditUserDoctorData? data;

  factory EditUserDoctorResponse.fromJson(Map<String, dynamic> json) =>
      EditUserDoctorResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : EditUserDoctorData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class EditUserDoctorData {
  EditUserDoctorData({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.license,
    this.image,
    this.about,
    this.experience,
    this.specialist,
    this.patientAttend,
    this.degree,
    this.phone,
    this.type,
    this.city,
    this.address,
    this.clinicAddress,
    this.state,
    this.zipCode,
    this.role,
    this.parentId,
    this.status,
    this.apiToken,
  });

  int? id;
  String? name;
  String? email;
  String? gender;
  String? license;
  String? image;
  String? about;
  String? experience;
  String? specialist;
  String? patientAttend;
  String? degree;
  String? phone;
  int? type;
  String? city;
  String? address;
  String? clinicAddress;
  String? state;
  int? zipCode;
  int? role;
  int? parentId;
  int? status;
  String? apiToken;

  factory EditUserDoctorData.fromJson(Map<String, dynamic> json) =>
      EditUserDoctorData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        gender: json["gender"],
        license: json["licence_no"] == null ? null : json["licence_no"],
        image: json["image"] == null ? null : json["image"],
        about: json["about"] == null ? null : json["about"],
        experience: json["experience"] == null ? null : json["experience"],
        specialist: json["specialist"] == null ? null : json["specialist"],
        patientAttend:
            json["patient_attend"] == null ? null : json["patient_attend"],
        degree: json["degree"] == null ? null : json["degree"],
        phone: json["phone"] == null ? null : json["phone"],
        type: json["type"] == null ? null : json["type"],
        city: json["city"] == null ? null : json["city"],
        address: json["address"] == null ? null : json["address"],
        clinicAddress:
            json["clinic_address"] == null ? null : json["clinic_address"],
        state: json["state"] == null ? null : json["state"],
        zipCode: json["zip_code"] == null ? null : json["zip_code"],
        role: json["role"] == null ? null : json["role"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        status: json["status"] == null ? null : json["status"],
        apiToken: json["api_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "gender": gender,
        "licence_no": license == null ? null : license,
        "image": image == null ? null : image,
        "about": about == null ? null : about,
        "experience": experience == null ? null : experience,
        "specialist": specialist == null ? null : specialist,
        "patient_attend": patientAttend == null ? null : patientAttend,
        "degree": degree == null ? null : degree,
        "phone": phone == null ? null : phone,
        "type": type == null ? null : type,
        "city": city == null ? null : city,
        "address": address == null ? null : address,
        "clinic_address": clinicAddress == null ? null : clinicAddress,
        "state": state == null ? null : state,
        "zip_code": zipCode == null ? null : zipCode,
        "role": role == null ? null : role,
        "parent_id": parentId == null ? null : parentId,
        "status": status == null ? null : status,
        "api_token": apiToken,
      };
}
