// To parse this JSON data, do

import 'dart:convert';

GetAllNotificationResponse notificationFromJson(String str) =>
    GetAllNotificationResponse.fromJson(json.decode(str));

String notificationToJson(GetAllNotificationResponse data) =>
    json.encode(data.toJson());

class GetAllNotificationResponse {
  GetAllNotificationResponse({
    this.status,
    this.message,
    this.readStatus,
    this.notificationCount,
    this.data,
    this.yearlier,
  });

  bool? status;
  String? message;
  int? readStatus;
  int? notificationCount;
  List<NotificationResponseData>? data;
  List<NotificationResponseData>? yearlier;

  factory GetAllNotificationResponse.fromJson(Map<String, dynamic> json) =>
      GetAllNotificationResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        readStatus: json["read_status"] == null ? null : json["read_status"],
        notificationCount: json["notification_count"] == null
            ? null
            : json["notification_count"],
        data: json["data"] == null
            ? null
            : List<NotificationResponseData>.from(
                json["data"].map((x) => NotificationResponseData.fromJson(x))),
        yearlier: json["yearlier"] == null
            ? null
            : List<NotificationResponseData>.from(json["yearlier"]
                .map((x) => NotificationResponseData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "read_status": readStatus == null ? null : readStatus,
        "notification_count":
            notificationCount == null ? null : notificationCount,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "yearlier": yearlier == null
            ? null
            : List<dynamic>.from(yearlier!.map((x) => x.toJson())),
      };
}

class NotificationResponseData {
  NotificationResponseData({
    this.id,
    this.userId,
    this.parent,
    this.doctorId,
    this.appType,
    this.notificationType,
    this.appointmentId,
    this.title,
    this.body,
    this.doctorBody,
    this.image,
    this.date,
    this.readStatus,
    this.doctorReadStatus,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  int? parent;
  int? doctorId;
  String? appType;
  String? notificationType;
  int? appointmentId;
  String? title;
  String? body;
  String? doctorBody;
  String? image;
  DateTime? date;
  int? readStatus;
  int? doctorReadStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NotificationResponseData.fromJson(Map<String, dynamic> json) =>
      NotificationResponseData(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        parent: json["parent"] == null ? null : json["parent"],
        doctorId: json["doctor_id"] == null ? null : json["doctor_id"],
        appType: json["app_type"] == null ? null : json["app_type"],
        notificationType: json["notification_type"] == null
            ? null
            : json["notification_type"],
        appointmentId:
            json["appointment_id"] == null ? null : json["appointment_id"],
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
        doctorBody: json["doctor_body"] == null ? null : json["doctor_body"],
        image: json["image"] == null ? null : json["image"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        readStatus: json["read_status"] == null ? null : json["read_status"],
        doctorReadStatus: json["doctor_read_status"] == null
            ? null
            : json["doctor_read_status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "parent": parent == null ? null : parent,
        "doctor_id": doctorId == null ? null : doctorId,
        "app_type": appType == null ? null : appType,
        "notification_type": notificationType == null ? null : notificationType,
        "appointment_id": appointmentId == null ? null : appointmentId,
        "title": title == null ? null : title,
        "body": body == null ? null : body,
        "doctor_body": doctorBody == null ? null : doctorBody,
        "image": image == null ? null : image,
        "date": date == null
            ? null
            : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "read_status": readStatus == null ? null : readStatus,
        "doctor_read_status":
            doctorReadStatus == null ? null : doctorReadStatus,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
