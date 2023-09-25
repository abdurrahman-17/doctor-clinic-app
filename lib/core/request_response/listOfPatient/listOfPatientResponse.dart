// To parse this JSON data, do
//
//     final listOfPatientResponse = listOfPatientResponseFromJson(jsonString);

import 'dart:convert';

ListOfPatientResponse listOfPatientResponseFromJson(String str) =>
    ListOfPatientResponse.fromJson(json.decode(str));

String listOfPatientResponseToJson(ListOfPatientResponse data) =>
    json.encode(data.toJson());

class ListOfPatientResponse {
  ListOfPatientResponse({
    this.status,
    this.message,
    this.data,
    this.registredPatientData,
  });

  bool? status;
  String? message;
  List<ListOfPatientData>? data;
  List<RegistredPatientDatum>? registredPatientData;

  factory ListOfPatientResponse.fromJson(Map<String, dynamic> json) =>
      ListOfPatientResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<ListOfPatientData>.from(
                json["data"].map((x) => ListOfPatientData.fromJson(x))),
        registredPatientData: json["registred_patient_data"] == null
            ? null
            : List<RegistredPatientDatum>.from(json["registred_patient_data"]
                .map((x) => RegistredPatientDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "registred_patient_data": registredPatientData == null
            ? null
            : List<dynamic>.from(registredPatientData!.map((x) => x.toJson())),
      };
}

class ListOfPatientData {
  ListOfPatientData({
    this.id,
    this.patientId,
    this.walkinId,
    this.doctorId,
    this.date,
    this.day,
    this.session,
    this.appointmentTime,
    this.tokenNo,
    this.patientName,
    this.description,
    this.type,
    this.dateofbirth,
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
    this.cancelReason,
    this.prescription,
    this.feedback,
    this.parentId,
    this.status,
    this.createdBy,
  });

  int? id;
  int? patientId;
  dynamic walkinId;
  int? doctorId;
  DateTime? date;
  String? day;
  String? session;
  dynamic appointmentTime;
  int? tokenNo;
  String? patientName;
  String? description;
  int? type;
  DateTime? dateofbirth;
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
  dynamic cancelReason;
  String? prescription;
  String? feedback;
  int? parentId;
  int? status;
  dynamic createdBy;

  factory ListOfPatientData.fromJson(Map<String, dynamic> json) =>
      ListOfPatientData(
        id: json["id"] == null ? null : json["id"],
        patientId: json["patient_id"] == null ? null : json["patient_id"],
        walkinId: json["walkin_id"],
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        day: json["day"] == null ? null : json["day"],
        session: json["session"] == null ? null : json["session"],
        appointmentTime: json["appointment_time"],
        tokenNo: json["token_no"] == null ? null : json["token_no"],
        patientName: json["patient_name"] == null ? null : json["patient_name"],
        description: json["description"] == null ? null : json["description"],
        type: json["type"] == null ? null : json["type"],
        dateofbirth: json["dateofbirth"] == null
            ? null
            : DateTime.parse(json["dateofbirth"]),
        gender: json["gender"] == null ? null : json["gender"],
        mobileNumber:
            json["mobile_number"] == null ? null : json["mobile_number"],
        height: json["height"] == null ? null : json["height"],
        weight: json["weight"] == null ? null : json["weight"],
        pulseRate: json["pulse_rate"] == null ? null : json["pulse_rate"],
        spo2: json["spo2"] == null ? null : json["spo2"],
        temperature: json["temperature"] == null ? null : json["temperature"],
        bloodPressure:
            json["blood_pressure"] == null ? null : json["blood_pressure"],
        heartBeat: json["heart_beat"],
        diabetes: json["diabetes"] == null ? null : json["diabetes"],
        consultation:
            json["consultation"] == null ? null : json["consultation"],
        cancelReason: json["cancel_reason"],
        prescription:
            json["prescription"] == null ? null : json["prescription"],
        feedback: json["feedback"] == null ? null : json["feedback"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        status: json["status"] == null ? null : json["status"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "patient_id": patientId == null ? null : patientId,
        "walkin_id": walkinId,
        "doctor_id": doctorId == null ? null : doctorId,
        "date": date == null
            ? null
            : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "day": day == null ? null : day,
        "session": session == null ? null : session,
        "appointment_time": appointmentTime,
        "token_no": tokenNo == null ? null : tokenNo,
        "patient_name": patientName == null ? null : patientName,
        "description": description == null ? null : description,
        "type": type == null ? null : type,
        "dateofbirth": dateofbirth == null
            ? null
            : "${dateofbirth!.year.toString().padLeft(4, '0')}-${dateofbirth!.month.toString().padLeft(2, '0')}-${dateofbirth!.day.toString().padLeft(2, '0')}",
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
        "cancel_reason": cancelReason,
        "prescription": prescription == null ? null : prescription,
        "feedback": feedback == null ? null : feedback,
        "parent_id": parentId == null ? null : parentId,
        "status": status == null ? null : status,
        "created_by": createdBy,
      };
}

class RegistredPatientDatum {
  RegistredPatientDatum({
    this.id,
    this.name,
    this.image,
    this.gender,
    this.mobileNumber,
    this.age,
    this.dateofbirth,
    this.createdAt,
    this.updateAt,
  });

  int? id;
  String? name;
  String? image;
  String? gender;
  int? mobileNumber;
  int? age;
  DateTime? dateofbirth;
  DateTime? createdAt;
  DateTime? updateAt;

  factory RegistredPatientDatum.fromJson(Map<String, dynamic> json) =>
      RegistredPatientDatum(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        image: json["image"] == null ? null : json["image"],
        gender: json["gender"] == null ? null : json["gender"],
        mobileNumber:
            json["mobile_number"] == null ? null : json["mobile_number"],
        age: json["age"] == null ? null : json["age"],
        dateofbirth: json["dateofbirth"] == null
            ? null
            : DateTime.parse(json["dateofbirth"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updateAt: json["update_at"] == null
            ? null
            : DateTime.parse(json["update_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "image": image == null ? null : image,
        "gender": gender == null ? null : gender,
        "mobile_number": mobileNumber == null ? null : mobileNumber,
        "age": age == null ? null : age,
        "dateofbirth": dateofbirth == null
            ? null
            : "${dateofbirth!.year.toString().padLeft(4, '0')}-${dateofbirth!.month.toString().padLeft(2, '0')}-${dateofbirth!.day.toString().padLeft(2, '0')}",
        "created_at": createdAt == null
            ? null
            : "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "update_at": updateAt == null
            ? null
            : "${updateAt!.year.toString().padLeft(4, '0')}-${updateAt!.month.toString().padLeft(2, '0')}-${updateAt!.day.toString().padLeft(2, '0')}",
      };
}
