// To parse this JSON data, do
//
//     final addDoctorScheduleTokenResponse = addDoctorScheduleTokenResponseFromJson(jsonString);

import 'dart:convert';

AddDoctorScheduleTokenResponse addDoctorScheduleTokenResponseFromJson(String str) => AddDoctorScheduleTokenResponse.fromJson(json.decode(str));

String addDoctorScheduleTokenResponseToJson(AddDoctorScheduleTokenResponse data) => json.encode(data.toJson());

class AddDoctorScheduleTokenResponse {
  AddDoctorScheduleTokenResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<Datum>? data;

  factory AddDoctorScheduleTokenResponse.fromJson(Map<String, dynamic> json) => AddDoctorScheduleTokenResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.doctorId,
    this.scheduleName,
    this.session,
    this.days,
    this.slotTime,
    this.scheduleType,
    this.fromTime,
    this.toTime,
    this.availableTokenTime,
    this.slotMember,
    this.status,
    this.updatedAt,
  });

  int? id;
  int? doctorId;
  String? scheduleName;
  String? session;
  String? days;
  int? slotTime;
  int? scheduleType;
  String? fromTime;
  String? toTime;
  String? availableTokenTime;
  int? slotMember;
  int? status;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    scheduleName: json["schedule_name"] == null ? null : json["schedule_name"],
    session: json["session"] == null ? null : json["session"],
    days: json["days"] == null ? null : json["days"],
    slotTime: json["slot_time"] == null ? null : json["slot_time"],
    scheduleType: json["schedule_type"] == null ? null : json["schedule_type"],
    fromTime: json["from_time"] == null ? null : json["from_time"],
    toTime: json["to_time"] == null ? null : json["to_time"],
    availableTokenTime: json["available_token_time"] == null ? null : json["available_token_time"],
    slotMember: json["slot_member"] == null ? null : json["slot_member"],
    status: json["status"] == null ? null : json["status"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "doctor_id": doctorId == null ? null : doctorId,
    "schedule_name": scheduleName == null ? null : scheduleName,
    "session": session == null ? null : session,
    "days": days == null ? null : days,
    "slot_time": slotTime == null ? null : slotTime,
    "schedule_type": scheduleType == null ? null : scheduleType,
    "from_time": fromTime == null ? null : fromTime,
    "to_time": toTime == null ? null : toTime,
    "available_token_time": availableTokenTime == null ? null : availableTokenTime,
    "slot_member": slotMember == null ? null : slotMember,
    "status": status == null ? null : status,
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}
