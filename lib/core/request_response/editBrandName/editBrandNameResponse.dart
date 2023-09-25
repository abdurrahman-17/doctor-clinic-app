import 'dart:convert';

EditBrandNameResponse editBrandNameResponseFromJson(String str) =>
    EditBrandNameResponse.fromJson(json.decode(str));

String editBrandNameResponseToJson(EditBrandNameResponse data) =>
    json.encode(data.toJson());

class EditBrandNameResponse {
  EditBrandNameResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory EditBrandNameResponse.fromJson(Map<String, dynamic> json) =>
      EditBrandNameResponse(
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
    this.id,
    this.medicineBrandName,
    this.status,
  });

  int? id;
  String? medicineBrandName;
  int? status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        medicineBrandName: json["medicine_brand_name"] == null
            ? null
            : json["medicine_brand_name"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "medicine_brand_name":
            medicineBrandName == null ? null : medicineBrandName,
        "status": status == null ? null : status,
      };
}
