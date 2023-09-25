// To parse this JSON data, do
//
//     final getDoctorScheduleResponse = getDoctorScheduleResponseFromJson(jsonString);

import 'dart:convert';

GetDoctorScheduleTimeResponse getDoctorScheduleResponseFromJson(String str) => GetDoctorScheduleTimeResponse.fromJson(json.decode(str));

String getDoctorScheduleResponseToJson(GetDoctorScheduleTimeResponse data) => json.encode(data.toJson());

class GetDoctorScheduleTimeResponse {
  GetDoctorScheduleTimeResponse({
    this.status,
    this.message,
    this.data,
    this.doctorSchedule,
  });

  bool? status;
  String? message;
  GetDoctorScheduleTimeData? data;
  DoctorSchedule? doctorSchedule;

  factory GetDoctorScheduleTimeResponse.fromJson(Map<String, dynamic> json) => GetDoctorScheduleTimeResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : GetDoctorScheduleTimeData.fromJson(json["data"]),
    doctorSchedule: json["doctor_schedule"] == null ? null : DoctorSchedule.fromJson(json["doctor_schedule"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
    "doctor_schedule": doctorSchedule == null ? null : doctorSchedule!.toJson(),
  };
}

class GetDoctorScheduleTimeData {
  GetDoctorScheduleTimeData({
    this.doctorId,
    this.morningTiming,
    this.scheduleName,
    this.days,
    this.afternoonTiming,
  });

  int? doctorId;
  String? morningTiming;
  String? scheduleName;
  String? days;
  String? afternoonTiming;

  factory GetDoctorScheduleTimeData.fromJson(Map<String, dynamic> json) => GetDoctorScheduleTimeData(
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    morningTiming: json["Morning_timing"] == null ? null : json["Morning_timing"],
    scheduleName: json["schedule_name"] == null ? null : json["schedule_name"],
    days: json["days"] == null ? null : json["days"],
    afternoonTiming: json["Afternoon_timing"] == null ? null : json["Afternoon_timing"],
  );

  Map<String, dynamic> toJson() => {
    "doctor_id": doctorId == null ? null : doctorId,
    "Morning_timing": morningTiming == null ? null : morningTiming,
    "schedule_name": scheduleName == null ? null : scheduleName,
    "days": days == null ? null : days,
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
    this.time,
    this.time12,
    this.status,
  });

  String? time;
  String? time12;
  int? status;

  factory Afternoon.fromJson(Map<String, dynamic> json) => Afternoon(
    time: json["time"] == null ? null : json["time"],
    time12: json["time12"] == null ? null : json["time12"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "time": time == null ? null : time,
    "time12": time12 == null ? null : time12,
    "status": status == null ? null : status,
  };
}
