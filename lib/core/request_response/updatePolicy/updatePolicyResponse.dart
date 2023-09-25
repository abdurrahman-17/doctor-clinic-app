// To parse this JSON data, do
//
//     final updatePolicyResponse = updatePolicyResponseFromJson(jsonString);

import 'dart:convert';

UpdatePolicyResponse updatePolicyResponseFromJson(String str) =>
    UpdatePolicyResponse.fromJson(json.decode(str));

String updatePolicyResponseToJson(UpdatePolicyResponse data) =>
    json.encode(data.toJson());

class UpdatePolicyResponse {
  UpdatePolicyResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  UpdatePolicyData? data;

  factory UpdatePolicyResponse.fromJson(Map<String, dynamic> json) =>
      UpdatePolicyResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : UpdatePolicyData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class UpdatePolicyData {
  UpdatePolicyData({
    this.id,
    this.clinicDocId,
    this.clinicPrivacyPolicy,
    this.clinicTermsAndCondition,
    this.clinicAboutUs,
  });

  int? id;
  String? clinicDocId;
  String? clinicPrivacyPolicy;
  String? clinicTermsAndCondition;
  String? clinicAboutUs;

  factory UpdatePolicyData.fromJson(Map<String, dynamic> json) =>
      UpdatePolicyData(
        id: json["id"] == null ? null : json["id"],
        clinicDocId:
            json["clinic_doc_id"] == null ? null : json["clinic_doc_id"],
        clinicPrivacyPolicy: json["clinic_privacy_policy"] == null
            ? null
            : json["clinic_privacy_policy"],
        clinicTermsAndCondition: json["clinic_terms_and_condition"] == null
            ? null
            : json["clinic_terms_and_condition"],
        clinicAboutUs:
            json["clinic_about_us"] == null ? null : json["clinic_about_us"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "clinic_doc_id": clinicDocId == null ? null : clinicDocId,
        "clinic_privacy_policy":
            clinicPrivacyPolicy == null ? null : clinicPrivacyPolicy,
        "clinic_terms_and_condition":
            clinicTermsAndCondition == null ? null : clinicTermsAndCondition,
        "clinic_about_us": clinicAboutUs == null ? null : clinicAboutUs,
      };
}
