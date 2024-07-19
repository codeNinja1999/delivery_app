part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final String? amount;
  final bool showAmount;
  final CalculationMode mode;
  final DetailedUser? userInfo;
  final FormStatus? tempStatus;
  final bool isResetCalculation;
  final List<ChartData>? chartData;
  final String? countryCodeForHistoryRate;
  final RateHistoryResult? rateHistoryResult;
  final List<ReceivingCountry> receivingCountryList;
  final ExchangeRateHistoryViewModel? exchangeRateHistoryViewModel;
  final List<TransactionListViewModel> pendingList;
  final CalculateTransactionResult? calculateTransactionResult;
  final FormStatus status;

  DashboardState({
    this.userInfo,
    this.tempStatus,
    this.amount,
    this.rateHistoryResult,
    this.chartData,
    this.countryCodeForHistoryRate,
    this.showAmount = false,
    this.exchangeRateHistoryViewModel,
    this.pendingList = const [],
    this.receivingCountryList = const [],
    this.calculateTransactionResult,
    this.isResetCalculation = false,
    this.mode = CalculationMode.viaBase,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  DashboardState copyWith({
    DetailedUser? userInfo,
    String? flag,
    String? amount,
    bool? showAmount,
    CalculationMode? mode,
    FormStatus? tempStatus,
    List<ChartData>? chartData,
    String? countryCodeForHistoryRate,
    RateHistoryResult? rateHistoryResult,
    List<ReceivingCountry>? receivingCountryList,
    List<TransactionListViewModel>? pendingList,
    ExchangeRateHistoryViewModel? exchangeRateHistoryViewModel,
    CalculateTransactionResult? calculateTransactionResult,
    bool? isReset,
    FormStatus? status,
  }) {
    return DashboardState(
      mode: mode ?? this.mode,
      tempStatus: tempStatus,
      amount: amount ?? this.amount,
      userInfo: userInfo ?? this.userInfo,
      chartData: chartData ?? this.chartData,
      showAmount: showAmount ?? this.showAmount,
      pendingList: pendingList ?? this.pendingList,
      rateHistoryResult: rateHistoryResult ?? this.rateHistoryResult,
      receivingCountryList: receivingCountryList ?? this.receivingCountryList,
      countryCodeForHistoryRate: countryCodeForHistoryRate ?? this.countryCodeForHistoryRate,
      exchangeRateHistoryViewModel: exchangeRateHistoryViewModel ?? this.exchangeRateHistoryViewModel,
      calculateTransactionResult: isReset == true ? null : calculateTransactionResult ?? this.calculateTransactionResult,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [
        userInfo,
        pendingList,
        mode,
        status,
        tempStatus,
        amount,
        showAmount,
        chartData,
        rateHistoryResult,
        receivingCountryList,
        exchangeRateHistoryViewModel,
        calculateTransactionResult,
        countryCodeForHistoryRate,
      ];
}
