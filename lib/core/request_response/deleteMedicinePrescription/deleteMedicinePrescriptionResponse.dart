import 'dart:convert';

DeleteMedicinePrescriptionResponse deleteMedicinePrescriptionResponseFromJson(
        String str) =>
    DeleteMedicinePrescriptionResponse.fromJson(json.decode(str));

String deleteMedicinePrescriptionResponseToJson(
        DeleteMedicinePrescriptionResponse data) =>
    json.encode(data.toJson());

class DeleteMedicinePrescriptionResponse {
  DeleteMedicinePrescriptionResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  Data? data;

  factory DeleteMedicinePrescriptionResponse.fromJson(
          Map<String, dynamic> json) =>
      DeleteMedicinePrescriptionResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.patientId,
    this.doctorId,
    this.medicineName,
    this.medicineQuantity,
    this.medicineFrequency,
    this.medicineTiming,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? patientId;
  int? doctorId;
  String? medicineName;
  String? medicineQuantity;
  String? medicineFrequency;
  String? medicineTiming;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        patientId: json["patient_id"] == null ? null : json["patient_id"],
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
        medicineName:
            json["medicine_name"] == null ? null : json["medicine_name"],
        medicineQuantity: json["medicine_quantity"] == null
            ? null
            : json["medicine_quantity"],
        medicineFrequency: json["medicine_frequency"] == null
            ? null
            : json["medicine_frequency"],
        medicineTiming:
            json["medicine_timing"] == null ? null : json["medicine_timing"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "patient_id": patientId == null ? null : patientId,
        "doctor_id": doctorId == null ? null : doctorId,
        "medicine_name": medicineName == null ? null : medicineName,
        "medicine_quantity": medicineQuantity == null ? null : medicineQuantity,
        "medicine_frequency":
            medicineFrequency == null ? null : medicineFrequency,
        "medicine_timing": medicineTiming == null ? null : medicineTiming,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
