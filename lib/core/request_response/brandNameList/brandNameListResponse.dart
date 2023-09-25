import 'dart:convert';

BrandNameListResponse brandNameListResponseFromJson(String str) =>
    BrandNameListResponse.fromJson(json.decode(str));

String brandNameListResponseToJson(BrandNameListResponse data) =>
    json.encode(data.toJson());

class BrandNameListResponse {
  BrandNameListResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<BrandNameData>? data;

  factory BrandNameListResponse.fromJson(Map<String, dynamic> json) =>
      BrandNameListResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<BrandNameData>.from(
                json["data"].map((x) => BrandNameData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BrandNameData {
  BrandNameData({
    this.id,
    this.medicineBrandName,
    this.status,
  });

  int? id;
  String? medicineBrandName;
  int? status;

  factory BrandNameData.fromJson(Map<String, dynamic> json) => BrandNameData(
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
