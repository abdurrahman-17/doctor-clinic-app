// To parse this JSON data, do
//
//     final graphWeekResponse = graphWeekResponseFromJson(jsonString);

import 'dart:convert';

GraphWeekResponse graphWeekResponseFromJson(String str) => GraphWeekResponse.fromJson(json.decode(str));

String graphWeekResponseToJson(GraphWeekResponse data) => json.encode(data.toJson());

class GraphWeekResponse {
  GraphWeekResponse({
    this.status,
    this.message,
    this.weeklyReport,
  });

  bool? status;
  String? message;
  List<WeeklyReportData>? weeklyReport;

  factory GraphWeekResponse.fromJson(Map<String, dynamic> json) => GraphWeekResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    weeklyReport: json["weekly_report"] == null ? null : List<WeeklyReportData>.from(json["weekly_report"].map((x) => WeeklyReportData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "weekly_report": weeklyReport == null ? null : List<dynamic>.from(weeklyReport!.map((x) => x.toJson())),
  };
}

class WeeklyReportData {
  WeeklyReportData({
    this.count,
    this.dayname,
  });

  int? count;
  String? dayname;

  factory WeeklyReportData.fromJson(Map<String, dynamic> json) => WeeklyReportData(
    count: json["count"] == null ? null : json["count"],
    dayname: json["dayname"] == null ? null : json["dayname"],
  );

  Map<String, dynamic> toJson() => {
    "count": count == null ? null : count,
    "dayname": dayname == null ? null : dayname,
  };
}
