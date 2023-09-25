import 'dart:convert';

AddDoctorResponse addDoctorResponseFromJson(String str) =>
    AddDoctorResponse.fromJson(json.decode(str));

String addDoctorResponseToJson(AddDoctorResponse data) =>
    json.encode(data.toJson());

class AddDoctorResponse {
  AddDoctorResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  AddDoctorData? data;

  factory AddDoctorResponse.fromJson(Map<String, dynamic> json) =>
      AddDoctorResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data:
            json["data"] == null ? null : AddDoctorData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class AddDoctorData {
  AddDoctorData({
    this.name,
    this.email,
    this.gender,
    this.patientAttend,
    this.about,
    this.image,
    this.experience,
    this.degree,
    this.phone,
    this.clinicAddress,
    this.role,
    this.specialist,
    this.parentId,
    this.id,
  });

  String? name;
  String? email;
  String? gender;
  String? patientAttend;
  String? about;
  String? experience;
  String? degree;
  String? image;
  String? phone;
  String? clinicAddress;
  String? role;
  String? specialist;
  int? parentId;
  int? id;

  factory AddDoctorData.fromJson(Map<String, dynamic> json) => AddDoctorData(
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        gender: json["gender"] == null ? null : json["gender"],
        patientAttend:
            json["patient_attend"] == null ? null : json["patient_attend"],
        about: json["about"] == null ? null : json["about"],
        image: json["image"] == null ? null : json["image"],
        experience: json["experience"] == null ? null : json["experience"],
        degree: json["degree"] == null ? null : json["degree"],
        phone: json["phone"] == null ? null : json["phone"],
        clinicAddress:
            json["clinic_address"] == null ? null : json["clinic_address"],
        role: json["role"] == null ? null : json["role"],
        specialist: json["specialist"] == null ? null : json["specialist"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "gender": gender == null ? null : gender,
        "patient_attend": patientAttend == null ? null : patientAttend,
        "about": about == null ? null : about,
        "image": image == null ? null : image,
        "experience": experience == null ? null : experience,
        "degree": degree == null ? null : degree,
        "phone": phone == null ? null : phone,
        "clinic_address": clinicAddress == null ? null : clinicAddress,
        "role": role == null ? null : role,
        "specialist": specialist == null ? null : specialist,
        "parent_id": parentId == null ? null : parentId,
        "id": id == null ? null : id,
      };
}
