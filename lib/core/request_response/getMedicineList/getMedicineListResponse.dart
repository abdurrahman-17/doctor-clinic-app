import 'dart:convert';

GetMedicineListResponse getMedicineListResponseFromJson(String str) =>
    GetMedicineListResponse.fromJson(json.decode(str));

String getMedicineListResponseToJson(GetMedicineListResponse data) =>
    json.encode(data.toJson());

class GetMedicineListResponse {
  GetMedicineListResponse({
    this.status,
    this.message,
    this.data,
  });

  bool? status;
  String? message;
  List<MedicineListData>? data;

  factory GetMedicineListResponse.fromJson(Map<String, dynamic> json) =>
      GetMedicineListResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<MedicineListData>.from(
                json["data"].map((x) => MedicineListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MedicineListData {
  MedicineListData({
    this.categoryName,
    this.id,
    this.categoryId,
    this.drugName,
    this.brandId,
    this.contentMeasurement,
    this.dosage,
    this.status,
    this.medicinePrescriptionStatus,
    this.doctorId,
    this.createdAt,
    this.updatedAt,
    this.medicineBrandName,
  });

  String? categoryName;
  int? id;
  int? categoryId;
  String? drugName;
  int? brandId;
  String? contentMeasurement;
  int? dosage;
  int? status;
  int? medicinePrescriptionStatus;
  dynamic doctorId;
  dynamic createdAt;
  dynamic updatedAt;
  String? medicineBrandName;

  factory MedicineListData.fromJson(Map<String, dynamic> json) =>
      MedicineListData(
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
        id: json["id"] == null ? null : json["id"],
        categoryId: json["category_id"] == null ? null : json["category_id"],
        drugName: json["drug_name"] == null ? null : json["drug_name"],
        brandId: json["brand_id"] == null ? null : json["brand_id"],
        contentMeasurement: json["content_measurement"] == null
            ? null
            : json["content_measurement"],
        dosage: json["dosage"] == null ? null : json["dosage"],
        status: json["status"] == null ? null : json["status"],
        medicinePrescriptionStatus: json["medicine_prescription_status"] == null
            ? null
            : json["medicine_prescription_status"],
        doctorId: json["doctor_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        medicineBrandName: json["medicine_brand_name"] == null
            ? null
            : json["medicine_brand_name"],
      );

  Map<String, dynamic> toJson() => {
        "category_name": categoryName == null ? null : categoryName,
        "id": id == null ? null : id,
        "category_id": categoryId == null ? null : categoryId,
        "drug_name": drugName == null ? null : drugName,
        "brand_id": brandId == null ? null : brandId,
        "content_measurement":
            contentMeasurement == null ? null : contentMeasurement,
        "dosage": dosage == null ? null : dosage,
        "status": status == null ? null : status,
        "medicine_prescription_status": medicinePrescriptionStatus == null
            ? null
            : medicinePrescriptionStatus,
        "doctor_id": doctorId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "medicine_brand_name":
            medicineBrandName == null ? null : medicineBrandName,
      };
}
