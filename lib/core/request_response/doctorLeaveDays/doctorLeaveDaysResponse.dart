import 'dart:convert';

DoctorLeaveDaysResponse doctorLeaveDaysResponseFromJson(String str) =>
    DoctorLeaveDaysResponse.fromJson(json.decode(str));

String doctorLeaveDaysResponseToJson(DoctorLeaveDaysResponse data) =>
    json.encode(data.toJson());

class DoctorLeaveDaysResponse {
  DoctorLeaveDaysResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<LeaveDaysData>? data;

  factory DoctorLeaveDaysResponse.fromJson(Map<String, dynamic> json) =>
      DoctorLeaveDaysResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<LeaveDaysData>.from(
                json["data"].map((x) => LeaveDaysData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class LeaveDaysData {
  LeaveDaysData({
    this.id,
    this.doctorId,
    this.fromDate,
    this.toDate,
    this.fromTime,
    this.toTime,
    this.description,
  });

  int? id;
  int? doctorId;
  DateTime? fromDate;
  DateTime? toDate;
  dynamic fromTime;
  dynamic toTime;
  dynamic description;

  factory LeaveDaysData.fromJson(Map<String, dynamic> json) => LeaveDaysData(
        id: json["id"] == null ? null : json["id"],
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
        fromDate: json["from_date"] == null
            ? null
            : DateTime.parse(json["from_date"]),
        toDate:
            json["to_date"] == null ? null : DateTime.parse(json["to_date"]),
        fromTime: json["from_time"],
        toTime: json["to_time"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "doctor_id": doctorId == null ? null : doctorId,
        "from_date": fromDate == null
            ? null
            : "${fromDate!.year.toString().padLeft(4, '0')}-${fromDate!.month.toString().padLeft(2, '0')}-${fromDate!.day.toString().padLeft(2, '0')}",
        "to_date": toDate == null
            ? null
            : "${toDate!.year.toString().padLeft(4, '0')}-${toDate!.month.toString().padLeft(2, '0')}-${toDate!.day.toString().padLeft(2, '0')}",
        "from_time": fromTime,
        "to_time": toTime,
        "description": description,
      };
}
