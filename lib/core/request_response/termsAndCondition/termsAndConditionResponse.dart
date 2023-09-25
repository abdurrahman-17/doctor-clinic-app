// To parse this JSON data, do
//
//     final termsAndConditionResponse = termsAndConditionResponseFromJson(jsonString);

import 'dart:convert';

TermsAndConditionResponse termsAndConditionResponseFromJson(String str) =>
    TermsAndConditionResponse.fromJson(json.decode(str));

String termsAndConditionResponseToJson(TermsAndConditionResponse data) =>
    json.encode(data.toJson());

class TermsAndConditionResponse {
  TermsAndConditionResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<TermsAndConditionData>? data;

  factory TermsAndConditionResponse.fromJson(Map<String, dynamic> json) =>
      TermsAndConditionResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<TermsAndConditionData>.from(
                json["data"].map((x) => TermsAndConditionData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TermsAndConditionData {
  TermsAndConditionData({
    this.id,
    this.clinicDocId,
    this.clinicTermsAndCondition,
  });

  int? id;
  String? clinicDocId;
  String? clinicTermsAndCondition;

  factory TermsAndConditionData.fromJson(Map<String, dynamic> json) =>
      TermsAndConditionData(
        id: json["id"] == null ? null : json["id"],
        clinicDocId:
            json["clinic_doc_id"] == null ? null : json["clinic_doc_id"],
        clinicTermsAndCondition: json["clinic_terms_and_condition"] == null
            ? null
            : json["clinic_terms_and_condition"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "clinic_doc_id": clinicDocId == null ? null : clinicDocId,
        "clinic_terms_and_condition":
            clinicTermsAndCondition == null ? null : clinicTermsAndCondition,
      };
}
