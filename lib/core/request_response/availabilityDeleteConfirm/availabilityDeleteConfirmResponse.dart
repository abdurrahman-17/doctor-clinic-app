// To parse this JSON data, do
//
//     final availabilityDeleteConfirmResponse = availabilityDeleteConfirmResponseFromJson(jsonString);

import 'dart:convert';

AvailabilityDeleteConfirmResponse availabilityDeleteConfirmResponseFromJson(String str) => AvailabilityDeleteConfirmResponse.fromJson(json.decode(str));

String availabilityDeleteConfirmResponseToJson(AvailabilityDeleteConfirmResponse data) => json.encode(data.toJson());

class AvailabilityDeleteConfirmResponse {
  AvailabilityDeleteConfirmResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  AvailabilityDeleteConfirmData? data;

  factory AvailabilityDeleteConfirmResponse.fromJson(Map<String, dynamic> json) => AvailabilityDeleteConfirmResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : AvailabilityDeleteConfirmData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class AvailabilityDeleteConfirmData {
  AvailabilityDeleteConfirmData({
    this.mon,
    this.tue,
    this.wed,
    this.thu,
    this.fri,
    this.sat,
    this.sun,
  });

  Fri? mon;
  Fri? tue;
  Fri? wed;
  Fri? thu;
  Fri? fri;
  Fri? sat;
  Fri? sun;

  factory AvailabilityDeleteConfirmData.fromJson(Map<String, dynamic> json) => AvailabilityDeleteConfirmData(
    mon: json["mon"] == null ? null : Fri.fromJson(json["mon"]),
    tue: json["tue"] == null ? null : Fri.fromJson(json["tue"]),
    wed: json["wed"] == null ? null : Fri.fromJson(json["wed"]),
    thu: json["thu"] == null ? null : Fri.fromJson(json["thu"]),
    fri: json["fri"] == null ? null : Fri.fromJson(json["fri"]),
    sat: json["sat"] == null ? null : Fri.fromJson(json["sat"]),
    sun: json["sun"] == null ? null : Fri.fromJson(json["sun"]),
  );

  Map<String, dynamic> toJson() => {
    "mon": mon == null ? null : mon!.toJson(),
    "tue": tue == null ? null : tue!.toJson(),
    "wed": wed == null ? null : wed!.toJson(),
    "thu": thu == null ? null : thu!.toJson(),
    "fri": fri == null ? null : fri!.toJson(),
    "sat": sat == null ? null : sat!.toJson(),
    "sun": sun == null ? null : sun!.toJson(),
  };
}

class Fri {
  Fri({
    this.days,
    this.session,
  });

  String? days;
  List<String>? session;

  factory Fri.fromJson(Map<String, dynamic> json) => Fri(
    days: json["days"] == null ? null : json["days"],
    session: json["session"] == null ? null : List<String>.from(json["session"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "days": days == null ? null : days,
    "session": session == null ? null : List<dynamic>.from(session!.map((x) => x)),
  };
}
