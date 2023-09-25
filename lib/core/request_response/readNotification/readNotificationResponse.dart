// To parse this JSON data, do

import 'dart:convert';

ReadNotification readNotificationFromJson(String str) => ReadNotification.fromJson(json.decode(str));

String readNotificationToJson(ReadNotification data) => json.encode(data.toJson());

class ReadNotification {
  ReadNotification({
    this.status,
    this.message,
  });

  bool? status;
  String? message;

  factory ReadNotification.fromJson(Map<String, dynamic> json) => ReadNotification(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
  };
}
