// To parse this JSON data, do
//
//     final addTimeWalkedInPatientResponse = addTimeWalkedInPatientResponseFromJson(jsonString);

import 'dart:convert';

AddTimeWalkedInPatientResponse addTimeWalkedInPatientResponseFromJson(String str) => AddTimeWalkedInPatientResponse.fromJson(json.decode(str));

String addTimeWalkedInPatientResponseToJson(AddTimeWalkedInPatientResponse data) => json.encode(data.toJson());

class AddTimeWalkedInPatientResponse {
  AddTimeWalkedInPatientResponse({
    this.status,
    this.message,
    this.data,
    this.doctorSchedule,
    this.addedFamily,
  });

  bool? status;
  String? message;
  TimeWalkedInData? data;
  DoctorSchedule? doctorSchedule;
  List<dynamic>? addedFamily;

  factory AddTimeWalkedInPatientResponse.fromJson(Map<String, dynamic> json) => AddTimeWalkedInPatientResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : TimeWalkedInData.fromJson(json["data"]),
    doctorSchedule: json["doctor_schedule"] == null ? null : DoctorSchedule.fromJson(json["doctor_schedule"]),
    addedFamily: json["added_family"] == null ? null : List<dynamic>.from(json["added_family"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
    "doctor_schedule": doctorSchedule == null ? null : doctorSchedule!.toJson(),
    "added_family": addedFamily == null ? null : List<dynamic>.from(addedFamily!.map((x) => x)),
  };
}

class TimeWalkedInData {
  TimeWalkedInData({
    this.doctorId,
    this.scheduleName,
    this.days,
  });

  int? doctorId;
  String? scheduleName;
  String? days;

  factory TimeWalkedInData.fromJson(Map<String, dynamic> json) => TimeWalkedInData(
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    scheduleName: json["schedule_name"] == null ? null : json["schedule_name"],
    days: json["days"] == null ? null : json["days"],
  );

  Map<String, dynamic> toJson() => {
    "doctor_id": doctorId == null ? null : doctorId,
    "schedule_name": scheduleName == null ? null : scheduleName,
    "days": days == null ? null : days,
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
    evening: json["Evening"] == null ? null : List<Afternoon>.from(json["Evening"].map((x) => x)),
    night: json["Night"] == null ? null : List<Afternoon>.from(json["Night"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Morning": morning == null ? null : List<dynamic>.from(morning!.map((x) => x.toJson())),
    "Afternoon": afternoon == null ? null : List<dynamic>.from(afternoon!.map((x) => x.toJson())),
    "Evening": evening == null ? null : List<dynamic>.from(evening!.map((x) => x)),
    "Night": night == null ? null : List<dynamic>.from(night!.map((x) => x)),
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
