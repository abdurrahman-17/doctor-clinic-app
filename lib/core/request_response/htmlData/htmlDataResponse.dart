import 'dart:convert';

HtmlDataResponse htmlDataResponseFromJson(String str) =>
    HtmlDataResponse.fromJson(json.decode(str));

String htmlDataResponseToJson(HtmlDataResponse data) =>
    json.encode(data.toJson());

class HtmlDataResponse {
  HtmlDataResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  String? data;

  factory HtmlDataResponse.fromJson(Map<String, dynamic> json) =>
      HtmlDataResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : json["data"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data,
      };
}
