class AnalyticsDataResponseModel {
  final int? totalRequests;
  final int? totalActiveRequests;
  final int? totalUsers;
  final int? totalOperators;
  final int? salesSummary;

  AnalyticsDataResponseModel({
    this.totalRequests,
    this.totalActiveRequests,
    this.totalUsers,
    this.totalOperators,
    this.salesSummary,
  });

  factory AnalyticsDataResponseModel.fromJson(Map<String, dynamic> json) => AnalyticsDataResponseModel(
        totalRequests: json["total_requests"],
        totalActiveRequests: json["total_active_requests"],
        totalUsers: json["total_users"],
        totalOperators: json["total_operators"],
        salesSummary: json["sales_summary"],
      );

  Map<String, dynamic> toJson() => {
        "total_requests": totalRequests,
        "total_active_requests": totalActiveRequests,
        "total_users": totalUsers,
        "total_operators": totalOperators,
        "sales_summary": salesSummary,
      };
}
