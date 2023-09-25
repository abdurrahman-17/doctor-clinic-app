// To parse this JSON data, do
//
//     final addAvailabilityDaysResponse = addAvailabilityDaysResponseFromJson(jsonString);

import 'dart:convert';

AddAvailabilityDaysResponse addAvailabilityDaysResponseFromJson(String str) => AddAvailabilityDaysResponse.fromJson(json.decode(str));

String addAvailabilityDaysResponseToJson(AddAvailabilityDaysResponse data) => json.encode(data.toJson());

class AddAvailabilityDaysResponse {
  AddAvailabilityDaysResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  AvailabilityDayStatusData? data;

  factory AddAvailabilityDaysResponse.fromJson(Map<String, dynamic> json) => AddAvailabilityDaysResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : AvailabilityDayStatusData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : data!.toJson(),
  };
}

class AvailabilityDayStatusData {
  AvailabilityDayStatusData({
    this.days,
  });

  List<Day>? days;

  factory AvailabilityDayStatusData.fromJson(Map<String, dynamic> json) => AvailabilityDayStatusData(
    days: json["days"] == null ? null : List<Day>.from(json["days"].map((x) => Day.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "days": days == null ? null : List<dynamic>.from(days!.map((x) => x.toJson())),
  };
}

class Day {
  Day({
    this.day,
    this.status,
  });

  String? day;
  int? status;

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    day: json["day"] == null ? null : json["day"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "day": day == null ? null : day,
    "status": status == null ? null : status,
  };
}
