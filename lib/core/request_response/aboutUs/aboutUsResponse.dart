// To parse this JSON data, do
//
//     final aboutUsResponse = aboutUsResponseFromJson(jsonString);

import 'dart:convert';

AboutUsResponse aboutUsResponseFromJson(String str) =>
    AboutUsResponse.fromJson(json.decode(str));

String aboutUsResponseToJson(AboutUsResponse data) =>
    json.encode(data.toJson());

class AboutUsResponse {
  AboutUsResponse({
    this.status,
    this.message,
    this.logo,
    this.aboutUsContent,
  });

  bool? status;
  String? message;
  Logo? logo;
  List<AboutUsContent>? aboutUsContent;

  factory AboutUsResponse.fromJson(Map<String, dynamic> json) =>
      AboutUsResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        logo: json["logo"] == null ? null : Logo.fromJson(json["logo"]),
        aboutUsContent: json["AboutUS_content"] == null
            ? null
            : List<AboutUsContent>.from(
                json["AboutUS_content"].map((x) => AboutUsContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "logo": logo == null ? null : logo!.toJson(),
        "AboutUS_content": aboutUsContent == null
            ? null
            : List<dynamic>.from(aboutUsContent!.map((x) => x.toJson())),
      };
}

class AboutUsContent {
  AboutUsContent({
    this.id,
    this.clinicDocId,
    this.clinicAboutUs,
  });

  int? id;
  String? clinicDocId;
  String? clinicAboutUs;

  factory AboutUsContent.fromJson(Map<String, dynamic> json) => AboutUsContent(
        id: json["id"] == null ? null : json["id"],
        clinicDocId:
            json["clinic_doc_id"] == null ? null : json["clinic_doc_id"],
        clinicAboutUs:
            json["clinic_about_us"] == null ? null : json["clinic_about_us"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "clinic_doc_id": clinicDocId == null ? null : clinicDocId,
        "clinic_about_us": clinicAboutUs == null ? null : clinicAboutUs,
      };
}

class Logo {
  Logo({
    this.image,
  });

  String? image;

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "image": image == null ? null : image,
      };
}
