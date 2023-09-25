// To parse this JSON data, do

import 'dart:convert';

NotificationCount notificationCountFromJson(String str) => NotificationCount.fromJson(json.decode(str));

String notificationCountToJson(NotificationCount data) => json.encode(data.toJson());

class NotificationCount {
  NotificationCount({
    this.status,
    this.message,
    this.notificationCount,
  });

  bool? status;
  String? message;
  int? notificationCount;

  factory NotificationCount.fromJson(Map<String, dynamic> json) => NotificationCount(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    notificationCount: json["notification_count"] == null ? null : json["notification_count"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "notification_count": notificationCount == null ? null : notificationCount,
  };
}
