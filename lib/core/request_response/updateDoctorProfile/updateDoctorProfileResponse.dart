// To parse this JSON data, do
//
//     final updateDoctorProfileResponse = updateDoctorProfileResponseFromJson(jsonString);

import 'dart:convert';

UpdateDoctorProfileResponse updateDoctorProfileResponseFromJson(String str) =>
    UpdateDoctorProfileResponse.fromJson(json.decode(str));

String updateDoctorProfileResponseToJson(UpdateDoctorProfileResponse data) =>
    json.encode(data.toJson());

class UpdateDoctorProfileResponse {
  UpdateDoctorProfileResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  UpdateDoctorProfileData? data;

  factory UpdateDoctorProfileResponse.fromJson(Map<String, dynamic> json) =>
      UpdateDoctorProfileResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : UpdateDoctorProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class UpdateDoctorProfileData {
  UpdateDoctorProfileData({
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
    this.deviceType,
    this.androidToken,
    this.iosToken,
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
  dynamic type;
  dynamic city;
  String? address;
  dynamic clinicAddress;
  dynamic state;
  dynamic zipCode;
  int? role;
  int? parentId;
  dynamic deviceType;
  dynamic androidToken;
  dynamic iosToken;
  int? status;
  dynamic apiToken;

  factory UpdateDoctorProfileData.fromJson(Map<String, dynamic> json) =>
      UpdateDoctorProfileData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        gender: json["gender"] == null ? null : json["gender"],
        license: json["licence_no"] == null ? null : json["licence_no"],
        image: json["image"] == null ? null : json["image"],
        about: json["about"] == null ? null : json["about"],
        experience: json["experience"] == null ? null : json["experience"],
        specialist: json["specialist"] == null ? null : json["specialist"],
        patientAttend:
            json["patient_attend"] == null ? null : json["patient_attend"],
        degree: json["degree"] == null ? null : json["degree"],
        phone: json["phone"] == null ? null : json["phone"],
        type: json["type"],
        city: json["city"],
        address: json["address"] == null ? null : json["address"],
        clinicAddress: json["clinic_address"],
        state: json["state"],
        zipCode: json["zip_code"],
        role: json["role"] == null ? null : json["role"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        deviceType: json["device_type"],
        androidToken: json["android_token"],
        iosToken: json["ios_token"],
        status: json["status"] == null ? null : json["status"],
        apiToken: json["api_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "gender": gender == null ? null : gender,
        "licence_no": license == null ? null : license,
        "image": image == null ? null : image,
        "about": about == null ? null : about,
        "experience": experience == null ? null : experience,
        "specialist": specialist == null ? null : specialist,
        "patient_attend": patientAttend == null ? null : patientAttend,
        "degree": degree == null ? null : degree,
        "phone": phone == null ? null : phone,
        "type": type,
        "city": city,
        "address": address == null ? null : address,
        "clinic_address": clinicAddress,
        "state": state,
        "zip_code": zipCode,
        "role": role == null ? null : role,
        "parent_id": parentId == null ? null : parentId,
        "device_type": deviceType,
        "android_token": androidToken,
        "ios_token": iosToken,
        "status": status == null ? null : status,
        "api_token": apiToken,
      };
}
