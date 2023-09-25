// To parse this JSON data, do
//
//     final registerUserFilterResponse = registerUserFilterResponseFromJson(jsonString);

import 'dart:convert';

RegisterUserFilterResponse registerUserFilterResponseFromJson(String str) =>
    RegisterUserFilterResponse.fromJson(json.decode(str));

String registerUserFilterResponseToJson(RegisterUserFilterResponse data) =>
    json.encode(data.toJson());

class RegisterUserFilterResponse {
  RegisterUserFilterResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<RegisterFilterData>? data;

  factory RegisterUserFilterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterUserFilterResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<RegisterFilterData>.from(
                json["data"].map((x) => RegisterFilterData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class RegisterFilterData {
  RegisterFilterData({
    this.id,
    this.email,
    this.password,
    this.name,
    this.mobileNumber,
    this.image,
    this.gender,
    this.age,
    this.dateofbirth,
    this.height,
    this.parent,
    this.report,
    this.apiToken,
    this.issue,
    this.notificationStatus,
    this.deviceType,
    this.deviceToken,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.status,
    this.pinAuthentication,
    this.createdAt,
    this.updateAt,
  });

  int? id;
  String? email;
  String? password;
  String? name;
  int? mobileNumber;
  String? image;
  dynamic gender;
  int? age;
  DateTime? dateofbirth;
  dynamic height;
  int? parent;
  dynamic report;
  String? apiToken;
  dynamic issue;
  int? notificationStatus;
  String? deviceType;
  String? deviceToken;
  String? address;
  String? city;
  String? state;
  int? zipCode;
  int? status;
  dynamic pinAuthentication;
  DateTime? createdAt;
  DateTime? updateAt;

  factory RegisterFilterData.fromJson(Map<String, dynamic> json) =>
      RegisterFilterData(
        id: json["id"] == null ? null : json["id"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        name: json["name"] == null ? null : json["name"],
        mobileNumber:
            json["mobile_number"] == null ? null : json["mobile_number"],
        image: json["image"] == null ? null : json["image"],
        gender: json["gender"],
        age: json["age"] == null ? null : json["age"],
        dateofbirth: json["dateofbirth"] == null
            ? null
            : DateTime.parse(json["dateofbirth"]),
        height: json["height"],
        parent: json["parent"] == null ? null : json["parent"],
        report: json["report"],
        apiToken: json["api_token"] == null ? null : json["api_token"],
        issue: json["issue"],
        notificationStatus: json["notification_status"] == null
            ? null
            : json["notification_status"],
        deviceType: json["device_type"] == null ? null : json["device_type"],
        deviceToken: json["device_token"] == null ? null : json["device_token"],
        address: json["address"] == null ? null : json["address"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        zipCode: json["zip_code"] == null ? null : json["zip_code"],
        status: json["status"] == null ? null : json["status"],
        pinAuthentication: json["pin_authentication"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updateAt: json["update_at"] == null
            ? null
            : DateTime.parse(json["update_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "name": name == null ? null : name,
        "mobile_number": mobileNumber == null ? null : mobileNumber,
        "image": image == null ? null : image,
        "gender": gender,
        "age": age == null ? null : age,
        "dateofbirth": dateofbirth == null
            ? null
            : "${dateofbirth!.year.toString().padLeft(4, '0')}-${dateofbirth!.month.toString().padLeft(2, '0')}-${dateofbirth!.day.toString().padLeft(2, '0')}",
        "height": height,
        "parent": parent == null ? null : parent,
        "report": report,
        "api_token": apiToken == null ? null : apiToken,
        "issue": issue,
        "notification_status":
            notificationStatus == null ? null : notificationStatus,
        "device_type": deviceType == null ? null : deviceType,
        "device_token": deviceToken == null ? null : deviceToken,
        "address": address == null ? null : address,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "zip_code": zipCode == null ? null : zipCode,
        "status": status == null ? null : status,
        "pin_authentication": pinAuthentication,
        "created_at": createdAt == null
            ? null
            : "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "update_at": updateAt == null
            ? null
            : "${updateAt!.year.toString().padLeft(4, '0')}-${updateAt!.month.toString().padLeft(2, '0')}-${updateAt!.day.toString().padLeft(2, '0')}",
      };
}
