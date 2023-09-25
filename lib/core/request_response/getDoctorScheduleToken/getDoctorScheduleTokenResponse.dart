// To parse this JSON data, do
//
//     final getDoctorScheduleTokenResponse = getDoctorScheduleTokenResponseFromJson(jsonString);

import 'dart:convert';

GetDoctorScheduleTokenResponse getDoctorScheduleTokenResponseFromJson(String str) => GetDoctorScheduleTokenResponse.fromJson(json.decode(str));

String getDoctorScheduleTokenResponseToJson(GetDoctorScheduleTokenResponse data) => json.encode(data.toJson());

class GetDoctorScheduleTokenResponse {
  GetDoctorScheduleTokenResponse({
    this.status,
    this.message,
    this.data,
    this.doctorSchedule,
  });

  bool? status;
  String? message;
  getTokenData? data;
  DoctorSchedule? doctorSchedule;

  factory GetDoctorScheduleTokenResponse.fromJson(Map<String, dynamic> json) => GetDoctorScheduleTokenResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : getTokenData.fromJson(json["data"]),
    doctorSchedule: json["doctor_schedule"] == null ? null : DoctorSchedule.fromJson(json["doctor_schedule"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
    "doctor_schedule": doctorSchedule == null ? null : doctorSchedule!.toJson(),
  };
}

class getTokenData {
  getTokenData({
    this.doctorId,
    this.scheduleName,
    this.days,
    this.morningTiming,
    this.afternoonTiming,
  });

  int? doctorId;
  String? scheduleName;
  String? days;
  String? morningTiming;
  String? afternoonTiming;

  factory getTokenData.fromJson(Map<String, dynamic> json) => getTokenData(
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    scheduleName: json["schedule_name"] == null ? null : json["schedule_name"],
    days: json["days"] == null ? null : json["days"],
    morningTiming: json["Morning_timing"] == null ? null : json["Morning_timing"],
    afternoonTiming: json["Afternoon_timing"] == null ? null : json["Afternoon_timing"],
  );

  Map<String, dynamic> toJson() => {
    "doctor_id": doctorId == null ? null : doctorId,
    "schedule_name": scheduleName == null ? null : scheduleName,
    "days": days == null ? null : days,
    "Morning_timing": morningTiming == null ? null : morningTiming,
    "Afternoon_timing": afternoonTiming == null ? null : afternoonTiming,
  };
}

class DoctorSchedule {
  DoctorSchedule({
    this.morning,
    this.afternoon,
    this.evening,
    this.night,
  });

  List<Afternoon>? morning;
  List<Afternoon>? afternoon;
  List<Afternoon>? evening;
  List<Afternoon>? night;

  factory DoctorSchedule.fromJson(Map<String, dynamic> json) => DoctorSchedule(
    morning: json["Morning"] == null ? null : List<Afternoon>.from(json["Morning"].map((x) => Afternoon.fromJson(x))),
    afternoon: json["Afternoon"] == null ? null : List<Afternoon>.from(json["Afternoon"].map((x) => Afternoon.fromJson(x))),
    evening: json["Evening"] == null ? null : List<Afternoon>.from(json["Evening"].map((x) => Afternoon.fromJson(x))),
    night: json["Night"] == null ? null : List<Afternoon>.from(json["Night"].map((x) => Afternoon.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Morning": morning == null ? null : List<dynamic>.from(morning!.map((x) => x.toJson())),
    "Afternoon": afternoon == null ? null : List<dynamic>.from(afternoon!.map((x) => x.toJson())),
    "Evening": evening == null ? null : List<dynamic>.from(evening!.map((x) => x.toJson())),
    "Night": night == null ? null : List<dynamic>.from(night!.map((x) => x.toJson())),
  };
}

class Afternoon {
  Afternoon({
    this.tokenNo,
    this.status,
  });

  String? tokenNo;
  int? status;

  factory Afternoon.fromJson(Map<String, dynamic> json) => Afternoon(
    tokenNo: json["token_no"] == null ? null : json["token_no"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "token_no": tokenNo == null ? null : tokenNo,
    "status": status == null ? null : status,
  };
}
