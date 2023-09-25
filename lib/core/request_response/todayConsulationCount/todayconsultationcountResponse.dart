// To parse this JSON data, do
//
//     final todayConsultationCountResponse = todayConsultationCountResponseFromJson(jsonString);

import 'dart:convert';

TodayConsultationCountResponse todayConsultationCountResponseFromJson(String str) => TodayConsultationCountResponse.fromJson(json.decode(str));

String todayConsultationCountResponseToJson(TodayConsultationCountResponse data) => json.encode(data.toJson());

class TodayConsultationCountResponse {
  TodayConsultationCountResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  ConsultData? data;

  factory TodayConsultationCountResponse.fromJson(Map<String, dynamic> json) => TodayConsultationCountResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : ConsultData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class ConsultData {
  ConsultData({
    this.consultationCount,
    this.checkInCount,
    this.doneCount,
  });

  int? consultationCount;
  int? checkInCount;
  int? doneCount;

  factory ConsultData.fromJson(Map<String, dynamic> json) => ConsultData(
    consultationCount: json["consultation_count"] == null ? null : json["consultation_count"],
    checkInCount: json["check_in_count"] == null ? null : json["check_in_count"],
    doneCount: json["done_count"] == null ? null : json["done_count"],
  );

  Map<String, dynamic> toJson() => {
    "consultation_count": consultationCount == null ? null : consultationCount,
    "check_in_count": checkInCount == null ? null : checkInCount,
    "done_count": doneCount == null ? null : doneCount,
  };
}
