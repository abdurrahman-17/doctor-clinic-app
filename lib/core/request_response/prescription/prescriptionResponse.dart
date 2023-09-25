// To parse this JSON data, do
//
//     final appointmentDetailResponse = appointmentDetailResponseFromJson(jsonString);

import 'dart:convert';

AppointmentDetailResponse appointmentDetailResponseFromJson(String str) => AppointmentDetailResponse.fromJson(json.decode(str));

String appointmentDetailResponseToJson(AppointmentDetailResponse data) => json.encode(data.toJson());

class AppointmentDetailResponse {
  AppointmentDetailResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<AppointmentDetailData>? data;

  factory AppointmentDetailResponse.fromJson(Map<String, dynamic> json) => AppointmentDetailResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<AppointmentDetailData>.from(json["data"].map((x) => AppointmentDetailData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AppointmentDetailData {
  AppointmentDetailData({
    this.id,
    this.patientId,
    this.patientName,
    this.doctorId,
    this.clinicAddress,
    this.doctorName,
    this.specialist,
    this.phone,
    this.date,
    this.day,
    this.appointmentTime,
    this.tokenNo,
    this.description,
    this.age,
    this.type,
    this.gender,
    this.mobileNumber,
    this.height,
    this.weight,
    this.pulseRate,
    this.spo2,
    this.temperature,
    this.bloodPressure,
    this.heartBeat,
    this.diabetes,
    this.consultation,
    this.prescription,
    this.status,
    this.feedback,
    this.parentId,
  });

  int? id;
  int? patientId;
  String? patientName;
  int? doctorId;
  String? clinicAddress;
  String? doctorName;
  String? specialist;
  String? phone;
  DateTime? date;
  String? day;
  String? appointmentTime;
  int? tokenNo;
  String? description;
  int? age;
  int? type;
  String? gender;
  String? mobileNumber;
  dynamic height;
  dynamic weight;
  String? pulseRate;
  String? spo2;
  int? temperature;
  int? bloodPressure;
  int? heartBeat;
  int? diabetes;
  int? consultation;
  List<String>? prescription;
  int? status;
  String? feedback;
  int? parentId;

  factory AppointmentDetailData.fromJson(Map<String, dynamic> json) => AppointmentDetailData(
    id: json["id"] == null ? null : json["id"],
    patientId: json["patient_id"] == null ? null : json["patient_id"],
    patientName: json["patient_name"] == null ? null : json["patient_name"],
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    clinicAddress: json["clinic_address"] == null ? null : json["clinic_address"],
    doctorName: json["doctor_name"] == null ? null : json["doctor_name"],
    specialist: json["specialist"] == null ? null : json["specialist"],
    phone: json["phone"] == null ? null : json["phone"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    day: json["day"] == null ? null : json["day"],
    appointmentTime: json["appointment_time"] == null ? null : json["appointment_time"],
    tokenNo: json["token_no"] == null ? null : json["token_no"],
    description: json["description"] == null ? null : json["description"],
    age: json["age"] == null ? null : json["age"],
    type: json["type"] == null ? null : json["type"],
    gender: json["gender"] == null ? null : json["gender"],
    mobileNumber: json["mobile_number"] == null ? null : json["mobile_number"],
    height: json["height"],
    weight: json["weight"],
    pulseRate: json["pulse_rate"] == null ? null : json["pulse_rate"],
    spo2: json["spo2"] == null ? null : json["spo2"],
    temperature: json["temperature"] == null ? null : json["temperature"],
    bloodPressure: json["blood_pressure"] == null ? null : json["blood_pressure"],
    heartBeat: json["heart_beat"] == null ? null : json["heart_beat"],
    diabetes: json["diabetes"] == null ? null : json["diabetes"],
    consultation: json["consultation"] == null ? null : json["consultation"],
    prescription: json["prescription"] == null ? null : List<String>.from(json["prescription"].map((x) => x)),
    status: json["status"] == null ? null : json["status"],
    feedback: json["feedback"] == null ? null : json["feedback"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "patient_id": patientId == null ? null : patientId,
    "patient_name": patientName == null ? null : patientName,
    "doctor_id": doctorId == null ? null : doctorId,
    "clinic_address": clinicAddress == null ? null : clinicAddress,
    "doctor_name": doctorName == null ? null : doctorName,
    "specialist": specialist == null ? null : specialist,
    "phone": phone == null ? null : phone,
    "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "day": day == null ? null : day,
    "appointment_time": appointmentTime == null ? null : appointmentTime,
    "token_no": tokenNo == null ? null : tokenNo,
    "description": description == null ? null : description,
    "age": age == null ? null : age,
    "type": type == null ? null : type,
    "gender": gender == null ? null : gender,
    "mobile_number": mobileNumber == null ? null : mobileNumber,
    "height": height,
    "weight": weight,
    "pulse_rate": pulseRate == null ? null : pulseRate,
    "spo2": spo2 == null ? null : spo2,
    "temperature": temperature == null ? null : temperature,
    "blood_pressure": bloodPressure == null ? null : bloodPressure,
    "heart_beat": heartBeat == null ? null : heartBeat,
    "diabetes": diabetes == null ? null : diabetes,
    "consultation": consultation == null ? null : consultation,
    "prescription": prescription == null ? null : List<dynamic>.from(prescription!.map((x) => x)),
    "status": status == null ? null : status,
    "feedback": feedback == null ? null : feedback,
    "parent_id": parentId == null ? null : parentId,
  };
}
