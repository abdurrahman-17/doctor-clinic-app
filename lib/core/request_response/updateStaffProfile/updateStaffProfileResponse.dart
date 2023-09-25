// To parse this JSON data, do
//
//     final updateStaffProfileResponse = updateStaffProfileResponseFromJson(jsonString);

import 'dart:convert';

UpdateStaffProfileResponse updateStaffProfileResponseFromJson(String str) => UpdateStaffProfileResponse.fromJson(json.decode(str));

String updateStaffProfileResponseToJson(UpdateStaffProfileResponse data) => json.encode(data.toJson());

class UpdateStaffProfileResponse {
  UpdateStaffProfileResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  UpdateStaffProfileData? data;

  factory UpdateStaffProfileResponse.fromJson(Map<String, dynamic> json) => UpdateStaffProfileResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : UpdateStaffProfileData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class UpdateStaffProfileData {
  UpdateStaffProfileData({
    this.id,
    this.name,
    this.email,
    this.image,
    this.phone,
    this.type,
    this.address,
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
  String? image;
  String? phone;
  dynamic type;
  String? address;
  int? role;
  int? parentId;
  dynamic deviceType;
  dynamic androidToken;
  dynamic iosToken;
  int? status;
  dynamic apiToken;

  factory UpdateStaffProfileData.fromJson(Map<String, dynamic> json) => UpdateStaffProfileData(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    image: json["image"] == null ? null : json["image"],
    phone: json["phone"] == null ? null : json["phone"],
    type: json["type"],
    address: json["address"] == null ? null : json["address"],
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
    "image": image == null ? null : image,
    "phone": phone == null ? null : phone,
    "type": type,
    "address": address == null ? null : address,
    "role": role == null ? null : role,
    "parent_id": parentId == null ? null : parentId,
    "device_type": deviceType,
    "android_token": androidToken,
    "ios_token": iosToken,
    "status": status == null ? null : status,
    "api_token": apiToken,
  };
}
