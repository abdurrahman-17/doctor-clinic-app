import 'dart:convert';

PieChartResponse pieChartResponseFromJson(String str) =>
    PieChartResponse.fromJson(json.decode(str));

String pieChartResponseToJson(PieChartResponse data) =>
    json.encode(data.toJson());

class PieChartResponse {
  PieChartResponse({
    this.status,
    this.message,
    this.monthlyReport,
  });

  bool? status;
  String? message;
  List<MonthlyPieReport>? monthlyReport;

  factory PieChartResponse.fromJson(Map<String, dynamic> json) =>
      PieChartResponse(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        monthlyReport: json["monthly_report"] == null
            ? null
            : List<MonthlyPieReport>.from(json["monthly_report"]
                .map((x) => MonthlyPieReport.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "monthly_report": monthlyReport == null
            ? null
            : List<dynamic>.from(monthlyReport!.map((x) => x.toJson())),
      };
}

class MonthlyPieReport {
  MonthlyPieReport({
    this.allAppoinmentCount,
    this.wakinAppoinmentCount,
    this.emgerencyAppoinmentCount,
  });

  int? allAppoinmentCount;
  int? wakinAppoinmentCount;
  int? emgerencyAppoinmentCount;

  factory MonthlyPieReport.fromJson(Map<String, dynamic> json) =>
      MonthlyPieReport(
        allAppoinmentCount: json["All_appoinment_count"] == null
            ? null
            : json["All_appoinment_count"],
        wakinAppoinmentCount: json["Wakin_appoinment_count"] == null
            ? null
            : json["Wakin_appoinment_count"],
        emgerencyAppoinmentCount: json["Emgerency_appoinment_count"] == null
            ? null
            : json["Emgerency_appoinment_count"],
      );

  Map<String, dynamic> toJson() => {
        "All_appoinment_count":
            allAppoinmentCount == null ? null : allAppoinmentCount,
        "Wakin_appoinment_count":
            wakinAppoinmentCount == null ? null : wakinAppoinmentCount,
        "Emgerency_appoinment_count":
            emgerencyAppoinmentCount == null ? null : emgerencyAppoinmentCount,
      };
}
