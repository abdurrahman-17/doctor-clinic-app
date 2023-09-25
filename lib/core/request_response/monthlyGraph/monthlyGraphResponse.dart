// To parse this JSON data, do
//
//     final monthlyGraphResponse = monthlyGraphResponseFromJson(jsonString);

import 'dart:convert';

MonthlyGraphResponse monthlyGraphResponseFromJson(String str) => MonthlyGraphResponse.fromJson(json.decode(str));

String monthlyGraphResponseToJson(MonthlyGraphResponse data) => json.encode(data.toJson());

class MonthlyGraphResponse {
  MonthlyGraphResponse({
    this.status,
    this.message,
    this.monthlyReport,
  });

  bool? status;
  String? message;
  List<MonthlyReport>? monthlyReport;

  factory MonthlyGraphResponse.fromJson(Map<String, dynamic> json) => MonthlyGraphResponse(
    status: json["status"] == null ? null : json["status"],
    message: json["message"] == null ? null : json["message"],
    monthlyReport: json["monthly_report"] == null ? null : List<MonthlyReport>.from(json["monthly_report"].map((x) => MonthlyReport.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "message": message == null ? null : message,
    "monthly_report": monthlyReport == null ? null : List<dynamic>.from(monthlyReport!.map((x) => x.toJson())),
  };
}

class MonthlyReport {
  MonthlyReport({
    this.count,
    this.monthname,
  });

  int? count;
  String? monthname;

  factory MonthlyReport.fromJson(Map<String, dynamic> json) => MonthlyReport(
    count: json["count"] == null ? null : json["count"],
    monthname: json["monthname"] == null ? null : json["monthname"],
  );

  Map<String, dynamic> toJson() => {
    "count": count == null ? null : count,
    "monthname": monthname == null ? null : monthname,
  };
}
