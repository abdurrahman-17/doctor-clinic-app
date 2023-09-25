// To parse this JSON data, do
//
//     final privayPolicyResponse = privayPolicyResponseFromJson(jsonString);

import 'dart:convert';

PrivayPolicyResponse privayPolicyResponseFromJson(String str) =>
    PrivayPolicyResponse.fromJson(json.decode(str));

String privayPolicyResponseToJson(PrivayPolicyResponse data) =>
    json.encode(data.toJson());

class PrivayPolicyResponse {
  PrivayPolicyResponse({
    this.status,
    this.message,
    this.logo,
    this.privacyPolicyContent,
  });

  bool? status;
  String? message;
  Logo? logo;
  List<PrivacyPolicyContent>? privacyPolicyContent;

  factory PrivayPolicyResponse.fromJson(Map<String, dynamic> json) =>
      PrivayPolicyResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        logo: json["logo"] == null ? null : Logo.fromJson(json["logo"]),
        privacyPolicyContent: json["PrivacyPolicy_content"] == null
            ? null
            : List<PrivacyPolicyContent>.from(json["PrivacyPolicy_content"]
                .map((x) => PrivacyPolicyContent.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "logo": logo == null ? null : logo!.toJson(),
        "PrivacyPolicy_content": privacyPolicyContent == null
            ? null
            : List<dynamic>.from(privacyPolicyContent!.map((x) => x.toJson())),
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

class PrivacyPolicyContent {
  PrivacyPolicyContent({
    this.id,
    this.clinicDocId,
    this.clinicPrivacyPolicy,
  });

  int? id;
  String? clinicDocId;
  String? clinicPrivacyPolicy;

  factory PrivacyPolicyContent.fromJson(Map<String, dynamic> json) =>
      PrivacyPolicyContent(
        id: json["id"] == null ? null : json["id"],
        clinicDocId:
            json["clinic_doc_id"] == null ? null : json["clinic_doc_id"],
        clinicPrivacyPolicy: json["clinic_privacy_policy"] == null
            ? null
            : json["clinic_privacy_policy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "clinic_doc_id": clinicDocId == null ? null : clinicDocId,
        "clinic_privacy_policy":
            clinicPrivacyPolicy == null ? null : clinicPrivacyPolicy,
      };
}
