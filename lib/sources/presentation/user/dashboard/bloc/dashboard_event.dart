part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class GetDashboardData extends DashboardEvent {}

class UserInfoSubscriptionRequested extends DashboardEvent {}

class TransactionListSubscriptionRequested extends DashboardEvent {}

class ShowAmountChanged extends DashboardEvent {
  final bool showAmount;
  ShowAmountChanged(this.showAmount);
}

class GetExchangeRateHistoryList extends DashboardEvent {
  final String? countryCodeForHistoryRate;
  GetExchangeRateHistoryList(this.countryCodeForHistoryRate);
}
