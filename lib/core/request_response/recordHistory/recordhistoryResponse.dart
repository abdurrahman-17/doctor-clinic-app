// To parse this JSON data, do
//
//     final recordHistoryResponse = recordHistoryResponseFromJson(jsonString);

import 'dart:convert';

RecordHistoryResponse recordHistoryResponseFromJson(String str) => RecordHistoryResponse.fromJson(json.decode(str));

String recordHistoryResponseToJson(RecordHistoryResponse data) => json.encode(data.toJson());

class RecordHistoryResponse {
  RecordHistoryResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<RecordHistoryData>? data;

  factory RecordHistoryResponse.fromJson(Map<String, dynamic> json) => RecordHistoryResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<RecordHistoryData>.from(json["data"].map((x) => RecordHistoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class RecordHistoryData {
  RecordHistoryData({
    this.appointmentId,
    this.bookedDate,
    this.bokedTime,
    this.doctorName,
    this.address,
    this.prescription,
    this.description,
    this.healthIssue,
  });

  int? appointmentId;
  DateTime? bookedDate;
  String? bokedTime;
  String? doctorName;
  String? address;
  String? prescription;
  String? description;
  String? healthIssue;

  factory RecordHistoryData.fromJson(Map<String, dynamic> json) => RecordHistoryData(
    appointmentId: json["appointment_id"] == null ? null : json["appointment_id"],
    bookedDate: json["booked_date"] == null ? null : DateTime.parse(json["booked_date"]),
    bokedTime: json["boked_time"] == null ? null : json["boked_time"],
    doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
    address: json["address"] == null ? null : json["address"],
    prescription: json["prescription"] == null ? null : json["prescription"],
    description: json["description"] == null ? null : json["description"],
    healthIssue: json["health_issue"] == null ? null : json["health_issue"],
  );

  Map<String, dynamic> toJson() => {
    "appointment_id": appointmentId == null ? null : appointmentId,
    "booked_date": bookedDate == null ? null : "${bookedDate!.year.toString().padLeft(4, '0')}-${bookedDate!.month.toString().padLeft(2, '0')}-${bookedDate!.day.toString().padLeft(2, '0')}",
    "boked_time": bokedTime == null ? null : bokedTime,
    "doctor_name": doctorName == null ? null : doctorName,
    "address": address == null ? null : address,
    "prescription": prescription == null ? null : prescription,
    "description": description == null ? null : description,
    "health_issue": healthIssue == null ? null : healthIssue,
  };
}
