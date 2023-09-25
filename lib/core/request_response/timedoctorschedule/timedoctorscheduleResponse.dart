// To parse this JSON data, do
//
//     final doctorScheduleResponse = doctorScheduleResponseFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

TimeDoctorScheduleResponse timeDoctorScheduleResponseFromJson(String str) => TimeDoctorScheduleResponse.fromJson(json.decode(str));

String timeDoctorScheduleResponseToJson(TimeDoctorScheduleResponse data) => json.encode(data.toJson());

class TimeDoctorScheduleResponse {
  TimeDoctorScheduleResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<TimeDoctorScheduleData>? data;

  factory TimeDoctorScheduleResponse.fromJson(Map<String, dynamic> json) => TimeDoctorScheduleResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<TimeDoctorScheduleData>.from(json["data"].map((x) => TimeDoctorScheduleData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TimeDoctorScheduleData {
  TimeDoctorScheduleData({
    this.id,
    this.doctorId,
    this.scheduleName,
    this.days,
    this.slotTime,
    this.scheduleType,
    this.fromTime,
    this.toTime,
    this.availableTokenTime,
  });

  int? id;
  int? doctorId;
  String? scheduleName;
  String? days;
  int? slotTime;
  int? scheduleType;
  String? fromTime;
  String? toTime;
  String? availableTokenTime;

  factory TimeDoctorScheduleData.fromJson(Map<String, dynamic> json) => TimeDoctorScheduleData(
    id: json["id"] == null ? null : json["id"],
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    scheduleName: json["schedule_name"] == null ? null : json["schedule_name"],
    days: json["days"] == null ? null : json["days"],
    slotTime: json["slot_time"] == null ? null : json["slot_time"],
    scheduleType: json["schedule_type"] == null ? null : json["schedule_type"],
    fromTime: json["from_time"] == null ? null : json["from_time"],
    toTime: json["to_time"] == null ? null : json["to_time"],
    availableTokenTime: json["available_token_time"] == null ? null : json["available_token_time"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "doctor_id": doctorId == null ? null : doctorId,
    "schedule_name": scheduleName == null ? null : scheduleName,
    "days": days == null ? null : days,
    "slot_time": slotTime == null ? null : slotTime,
    "schedule_type": scheduleType == null ? null : scheduleType,
    "from_time": fromTime == null ? null : fromTime,
    "to_time": toTime == null ? null : toTime,
    "available_token_time": availableTokenTime == null ? null : availableTokenTime,
  };
}
