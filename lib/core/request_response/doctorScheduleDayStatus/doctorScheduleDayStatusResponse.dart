// To parse this JSON data, do
//
//     final doctorScheduleDayStatus = doctorScheduleDayStatusFromJson(jsonString);

import 'dart:convert';

DoctorScheduleDayStatusResponse doctorScheduleDayStatusFromJson(String str) => DoctorScheduleDayStatusResponse.fromJson(json.decode(str));

String doctorScheduleDayStatusToJson(DoctorScheduleDayStatusResponse data) => json.encode(data.toJson());

class DoctorScheduleDayStatusResponse {
  DoctorScheduleDayStatusResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  DayScheduleStatusData? data;

  factory DoctorScheduleDayStatusResponse.fromJson(Map<String, dynamic> json) => DoctorScheduleDayStatusResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : DayScheduleStatusData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class DayScheduleStatusData {
  DayScheduleStatusData({
    this.days,
  });

  List<Day>? days;

  factory DayScheduleStatusData.fromJson(Map<String, dynamic> json) => DayScheduleStatusData(
    days: json["days"] == null ? null : List<Day>.from(json["days"].map((x) => Day.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "days": days == null ? null : List<dynamic>.from(days!.map((x) => x.toJson())),
  };
}

class Day {
  Day({
    this.status,
    this.day,
  });

  int? status;
  String? day;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    status: json["status"] == null ? null : json["status"],
    day: json["day"] == null ? null : json["day"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "day": day == null ? null : day,
  };
}
