part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final String? amount;
  final bool showAmount;
  final DetailedUser? userInfo;
  final FormStatus? tempStatus;
  final bool isResetCalculation;
  final String? countryCodeForHistoryRate;
  final List<ReceivingCountry> receivingCountryList;
  final List<TransactionListViewModel> pendingList;
  final FormStatus status;

  DashboardState({
    this.userInfo,
    this.tempStatus,
    this.amount,
    this.countryCodeForHistoryRate,
    this.showAmount = false,
    this.pendingList = const [],
    this.receivingCountryList = const [],
    this.isResetCalculation = false,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  DashboardState copyWith({
    DetailedUser? userInfo,
    String? flag,
    String? amount,
    bool? showAmount,
    FormStatus? tempStatus,
    String? countryCodeForHistoryRate,
    List<ReceivingCountry>? receivingCountryList,
    List<TransactionListViewModel>? pendingList,
    bool? isReset,
    FormStatus? status,
  }) {
    return DashboardState(
      tempStatus: tempStatus,
      amount: amount ?? this.amount,
      userInfo: userInfo ?? this.userInfo,
      showAmount: showAmount ?? this.showAmount,
      pendingList: pendingList ?? this.pendingList,
      receivingCountryList: receivingCountryList ?? this.receivingCountryList,
      countryCodeForHistoryRate: countryCodeForHistoryRate ?? this.countryCodeForHistoryRate,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [
        userInfo,
        pendingList,
        status,
        tempStatus,
        amount,
        showAmount,
        receivingCountryList,
        countryCodeForHistoryRate,
      ];
}
