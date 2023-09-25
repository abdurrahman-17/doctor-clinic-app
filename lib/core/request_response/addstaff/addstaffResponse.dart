import 'dart:convert';

AddStaffResponse addStaffResponseFromJson(String str) =>
    AddStaffResponse.fromJson(json.decode(str));

String addStaffResponseToJson(AddStaffResponse data) =>
    json.encode(data.toJson());

class AddStaffResponse {
  AddStaffResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory AddStaffResponse.fromJson(Map<String, dynamic> json) =>
      AddStaffResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.name,
    this.email,
    this.phone,
    this.address,
    this.role,
    this.parentId,
    this.id,
  });

  String? name;
  String? email;
  String? phone;
  String? address;
  String? role;
  int? parentId;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        address: json["address"] == null ? null : json["address"],
        role: json["role"] == null ? null : json["role"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "address": address == null ? null : address,
        "role": role == null ? null : role,
        "parent_id": parentId == null ? null : parentId,
        "id": id == null ? null : id,
      };
}
