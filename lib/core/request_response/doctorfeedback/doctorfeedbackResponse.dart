// To parse this JSON data, do
//
//     final doctorFeedBackResponse = doctorFeedBackResponseFromJson(jsonString);

import 'dart:convert';

DoctorFeedBackResponse doctorFeedBackResponseFromJson(String str) => DoctorFeedBackResponse.fromJson(json.decode(str));

String doctorFeedBackResponseToJson(DoctorFeedBackResponse data) => json.encode(data.toJson());

class DoctorFeedBackResponse {
  DoctorFeedBackResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<DoctorFeedbackData>? data;

  factory DoctorFeedBackResponse.fromJson(Map<String, dynamic> json) => DoctorFeedBackResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    data: json["data"] == null ? null : List<DoctorFeedbackData>.from(json["data"].map((x) => DoctorFeedbackData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DoctorFeedbackData {
  DoctorFeedbackData({
    this.id,
    this.patientId,
    this.doctorId,
    this.date,
    this.day,
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
    this.healthIssue,
  });

  int? id;
  int? patientId;
  int? doctorId;
  DateTime? date;
  String? day;
  String? appointmentTime;
  dynamic tokenNo;
  String? patientName;
  String? description;
  dynamic age;
  int? type;
  String? gender;
  String? mobileNumber;
  int? height;
  int? weight;
  String? pulseRate;
  String? spo2;
  int? temperature;
  int? bloodPressure;
  dynamic heartBeat;
  int? diabetes;
  int? consultation;
  List<String>? prescription;
  String? feedback;
  int? status;
  int? parentId;
  HealthIssue? healthIssue;

  factory DoctorFeedbackData.fromJson(Map<String, dynamic> json) => DoctorFeedbackData(
    id: json["id"] == null ? null : json["id"],
    patientId: json["patient_id"] == null ? null : json["patient_id"],
    doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    day: json["day"] == null ? null : json["day"],
    appointmentTime: json["appointment_time"] == null ? null : json["appointment_time"],
    tokenNo: json["token_no"],
    patientName: json["patient_name"] == null ? null : json["patient_name"],
    description: json["description"] == null ? null : json["description"],
    age: json["age"],
    type: json["type"] == null ? null : json["type"],
    gender: json["gender"] == null ? null : json["gender"],
    mobileNumber: json["mobile_number"] == null ? null : json["mobile_number"],
    height: json["height"] == null ? null : json["height"],
    weight: json["weight"] == null ? null : json["weight"],
    pulseRate: json["pulse_rate"] == null ? null : json["pulse_rate"],
    spo2: json["spo2"] == null ? null : json["spo2"],
    temperature: json["temperature"] == null ? null : json["temperature"],
    bloodPressure: json["blood_pressure"] == null ? null : json["blood_pressure"],
    heartBeat: json["heart_beat"],
    diabetes: json["diabetes"] == null ? null : json["diabetes"],
    consultation: json["consultation"] == null ? null : json["consultation"],
    prescription: json["prescription"] == null ? null : List<String>.from(json["prescription"].map((x) => x)),
    feedback: json["feedback"] == null ? null : json["feedback"],
    status: json["status"] == null ? null : json["status"],
    parentId: json["parent_id"] == null ? null : json["parent_id"],
    healthIssue: json["health_issue"] == null ? null : HealthIssue.fromJson(json["health_issue"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "patient_id": patientId == null ? null : patientId,
    "doctor_id": doctorId == null ? null : doctorId,
    "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "day": day == null ? null : day,
    "appointment_time": appointmentTime == null ? null : appointmentTime,
    "token_no": tokenNo,
    "patient_name": patientName == null ? null : patientName,
    "description": description == null ? null : description,
    "age": age,
    "type": type == null ? null : type,
    "gender": gender == null ? null : gender,
    "mobile_number": mobileNumber == null ? null : mobileNumber,
    "height": height == null ? null : height,
    "weight": weight == null ? null : weight,
    "pulse_rate": pulseRate == null ? null : pulseRate,
    "spo2": spo2 == null ? null : spo2,
    "temperature": temperature == null ? null : temperature,
    "blood_pressure": bloodPressure == null ? null : bloodPressure,
    "heart_beat": heartBeat,
    "diabetes": diabetes == null ? null : diabetes,
    "consultation": consultation == null ? null : consultation,
    "prescription": prescription == null ? null : List<dynamic>.from(prescription!.map((x) => x)),
    "feedback": feedback == null ? null : feedback,
    "status": status == null ? null : status,
    "parent_id": parentId == null ? null : parentId,
    "health_issue": healthIssue == null ? null : healthIssue!.toJson(),
  };
}

class HealthIssue {
  HealthIssue({
    this.issue,
  });

  String? issue;

  factory HealthIssue.fromJson(Map<String, dynamic> json) => HealthIssue(
    issue: json["issue"] == null ? null : json["issue"],
  );

  Map<String, dynamic> toJson() => {
    "issue": issue == null ? null : issue,
  };
}
