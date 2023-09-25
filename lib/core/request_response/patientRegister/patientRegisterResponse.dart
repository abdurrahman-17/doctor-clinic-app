import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.status,
    this.message,
    this.data,
    this.error,
  });

  bool? status;
  String? message;
  Data? data;
  Error? error;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
        "error": error == null ? null : error!.toJson(),
      };
}

class Data {
  Data({
    this.name,
    this.email,
    this.dateofbirth,
    this.address,
    this.image,
    this.city,
    this.state,
    this.mobileNumber,
    this.zipCode,
    this.password,
    this.id,
  });

  String? name;
  String? email;
  DateTime? dateofbirth;
  String? address;
  String? image;
  String? city;
  String? state;
  String? mobileNumber;
  String? zipCode;
  String? password;
  int? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        dateofbirth: json["dateofbirth"] == null
            ? null
            : DateTime.parse(json["dateofbirth"]),
        address: json["address"] == null ? null : json["address"],
        image: json["image"] == null ? null : json["image"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        mobileNumber:
            json["mobile_number"] == null ? null : json["mobile_number"],
        zipCode: json["zip_code"] == null ? null : json["zip_code"],
        password: json["password"] == null ? null : json["password"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "dateofbirth": dateofbirth == null
            ? null
            : "${dateofbirth!.year.toString().padLeft(4, '0')}-${dateofbirth!.month.toString().padLeft(2, '0')}-${dateofbirth!.day.toString().padLeft(2, '0')}",
        "address": address == null ? null : address,
        "image": image == null ? null : image,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "mobile_number": mobileNumber == null ? null : mobileNumber,
        "zip_code": zipCode == null ? null : zipCode,
        "password": password == null ? null : password,
        "id": id == null ? null : id,
      };
}

class Error {
  Error({
    this.email,
    this.mobileNumber,
  });

  List<String>? email;
  List<String>? mobileNumber;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        email: json["email"] == null
            ? null
            : List<String>.from(json["email"].map((x) => x)),
        mobileNumber: json["mobile_number"] == null
            ? null
            : List<String>.from(json["mobile_number"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email":
            email == null ? null : List<dynamic>.from(email!.map((x) => x)),
        "mobile_number": mobileNumber == null
            ? null
            : List<dynamic>.from(mobileNumber!.map((x) => x)),
      };
}
