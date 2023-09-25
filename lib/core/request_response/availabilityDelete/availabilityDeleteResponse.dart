// To parse this JSON data, do
//
//     final availabilityDeleteResponse = availabilityDeleteResponseFromJson(jsonString);

import 'dart:convert';

AvailabilityDeleteResponse availabilityDeleteResponseFromJson(String str) => AvailabilityDeleteResponse.fromJson(json.decode(str));

String availabilityDeleteResponseToJson(AvailabilityDeleteResponse data) => json.encode(data.toJson());

class AvailabilityDeleteResponse {
  AvailabilityDeleteResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<AvialbilityDeleteData>? data;

  factory AvailabilityDeleteResponse.fromJson(Map<String, dynamic> json) => AvailabilityDeleteResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<AvialbilityDeleteData>.from(json["data"].map((x) => AvialbilityDeleteData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AvialbilityDeleteData {
  AvialbilityDeleteData({
    this.id,
    this.patientId,
    this.doctorId,
    this.date,
    this.day,
    this.session,
    this.appointmentTime,
    this.tokenNo,
    this.patientName,
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
    this.feedback,
    this.status,
    this.parentId,
  });

  int? id;
  int? patientId;
  int? doctorId;
  DateTime? date;
  String? day;
  String? session;
  String? appointmentTime;
  dynamic tokenNo;
  String? patientName;
  String? description;
  int? age;
  int? type;
  String? gender;
  dynamic mobileNumber;
  dynamic height;
  dynamic weight;
  dynamic pulseRate;
  dynamic spo2;
  dynamic temperature;
  dynamic bloodPressure;
  dynamic heartBeat;
  dynamic diabetes;
  int? consultation;
  dynamic prescription;
  dynamic feedback;
  int? status;
  int? parentId;

  factory AvialbilityDeleteData.fromJson(Map<String, dynamic> json) => AvialbilityDeleteData(
    id: json["id"] == null ? null : json["id"],
    patientId: json["patient_id"] == null ? null : json["patient_id"],
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    day: json["day"] == null ? null : json["day"],
    session: json["session"] == null ? null : json["session"],
    appointmentTime: json["appointment_time"] == null ? null : json["appointment_time"],
    tokenNo: json["token_no"],
    patientName: json["patient_name"] == null ? null : json["patient_name"],
    description: json["description"] == null ? null : json["description"],
    age: json["age"] == null ? null : json["age"],
    type: json["type"] == null ? null : json["type"],
    gender: json["gender"] == null ? null : json["gender"],
    mobileNumber: json["mobile_number"],
    height: json["height"],
    weight: json["weight"],
    pulseRate: json["pulse_rate"],
    spo2: json["spo2"],
    temperature: json["temperature"],
    bloodPressure: json["blood_pressure"],
    heartBeat: json["heart_beat"],
    diabetes: json["diabetes"],
    consultation: json["consultation"] == null ? null : json["consultation"],
    prescription: json["prescription"],
    feedback: json["feedback"],
    status: json["status"] == null ? null : json["status"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "patient_id": patientId == null ? null : patientId,
    "doctor_id": doctorId == null ? null : doctorId,
    "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "day": day == null ? null : day,
    "session": session == null ? null : session,
    "appointment_time": appointmentTime == null ? null : appointmentTime,
    "token_no": tokenNo,
    "patient_name": patientName == null ? null : patientName,
    "description": description == null ? null : description,
    "age": age == null ? null : age,
    "type": type == null ? null : type,
    "gender": gender == null ? null : gender,
    "mobile_number": mobileNumber,
    "height": height,
    "weight": weight,
    "pulse_rate": pulseRate,
    "spo2": spo2,
    "temperature": temperature,
    "blood_pressure": bloodPressure,
    "heart_beat": heartBeat,
    "diabetes": diabetes,
    "consultation": consultation == null ? null : consultation,
    "prescription": prescription,
    "feedback": feedback,
    "status": status == null ? null : status,
    "parent_id": parentId == null ? null : parentId,
  };
}
