import '../../../domain/user/entities/analytic_data_info.dart';
import '../model/analytics_data_response_model.dart';

extension AnalyticsDataResponseMapping on AnalyticsDataResponseModel {
  AnalyticDataInfo toAnalyticData() {
    final analyticData = AnalyticDataInfo(
      totalRequest: totalRequests.toString(),
      totalActiveRequests: totalActiveRequests.toString(),
      totalUser: totalUsers.toString(),
      totalOperator: totalOperators.toString(),
      sales: salesSummary.toString(),
    );
    return analyticData;
  }
}
