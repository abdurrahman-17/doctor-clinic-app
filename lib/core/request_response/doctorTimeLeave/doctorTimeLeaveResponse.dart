import 'dart:convert';

DoctorTimeLeaveResponse doctorTimeLeaveResponseFromJson(String str) =>
    DoctorTimeLeaveResponse.fromJson(json.decode(str));

String doctorTimeLeaveResponseToJson(DoctorTimeLeaveResponse data) =>
    json.encode(data.toJson());

class DoctorTimeLeaveResponse {
  DoctorTimeLeaveResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<DoctorTimeLeaveData>? data;

  factory DoctorTimeLeaveResponse.fromJson(Map<String, dynamic> json) =>
      DoctorTimeLeaveResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DoctorTimeLeaveData>.from(
                json["data"].map((x) => DoctorTimeLeaveData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DoctorTimeLeaveData {
  DoctorTimeLeaveData({
    this.id,
    this.patientId,
    this.doctorId,
    this.patientName,
    this.mobileNumber,
    this.tokenNo,
    this.date,
    this.appointmentTime,
  });

  int? id;
  int? patientId;
  int? doctorId;
  String? patientName;
  int? mobileNumber;
  int? tokenNo;
  DateTime? date;
  String? appointmentTime;

  factory DoctorTimeLeaveData.fromJson(Map<String, dynamic> json) =>
      DoctorTimeLeaveData(
        id: json["id"] == null ? null : json["id"],
        patientId: json["patient_id"] == null ? null : json["patient_id"],
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
        patientName: json["patient_name"] == null ? null : json["patient_name"],
        mobileNumber:
            json["mobile_number"] == null ? null : json["mobile_number"],
        tokenNo: json["token_no"] == null ? null : json["token_no"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        appointmentTime:
            json["appointment_time"] == null ? null : json["appointment_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "patient_id": patientId == null ? null : patientId,
        "doctor_id": doctorId == null ? null : doctorId,
        "patient_name": patientName == null ? null : patientName,
        "mobile_number": mobileNumber == null ? null : mobileNumber,
        "token_no": tokenNo == null ? null : tokenNo,
        "date": date == null
            ? null
            : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "appointment_time": appointmentTime == null ? null : appointmentTime,
      };
}
