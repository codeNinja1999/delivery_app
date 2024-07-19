import 'package:fresh_fold_delivery/repository/repository.dart';

import 'package:fresh_fold_delivery/sources/config/config.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

class ExchangeRateHistoryViewModel {
  final double? min;
  final double? max;
  final double? interval;
  final String exchangeRate;

  final String? receivingCountryFlag;
  final List<ChartData>? chartData;
  final String? counterCurrencyCode;
  final RateHistoryResult? rateHistoryResult;

  ExchangeRateHistoryViewModel({
    this.min,
    this.max,
    this.interval,
    this.chartData,
    this.exchangeRate = "",
    this.counterCurrencyCode,
    this.receivingCountryFlag,
    required this.rateHistoryResult,
  });

  factory ExchangeRateHistoryViewModel.fromHistory(RateHistoryResult? data, ReceivingCountry? receivingCountry) {
    final staticInterval = double.parse(data?.interval ?? "0.5");
    return ExchangeRateHistoryViewModel(
      min: double.parse(data?.minValue ?? "0.2") - staticInterval,
      max: double.parse(data?.maxValue ?? "1.0") + staticInterval,
      interval: staticInterval,
      exchangeRate: "1 ${AppConstants.senderCurrencyCode} = ${data?.rateHistoryList?.first?.rate ?? "0.0"}",
      chartData:
          (data?.rateHistoryList != null) ? data?.rateHistoryList?.map((e) => ChartData.fromRateHistory(e)).toList() : null,
      receivingCountryFlag: "${AppConstants.countryImageUrl}${data?.countryCode?.toLowerCase()}.svg",
      counterCurrencyCode: data?.counterCurrencyCode,
      rateHistoryResult: data,
    );
  }
}

class ChartData {
  ChartData(this.date, this.year, this.rate);
  final DateTime date;
  final String year;
  final double rate;

  factory ChartData.fromRateHistory(RateHistory? data) {
    DateTime dateTime = DateFormat("M/dd/yyyy").parse(data?.date ?? "1/19/2024 11:15:44 AM");
    // String formattedDate = DateFormat("yyyy-MM-dd").format(dateTime);
    final month = DateFormat("MMM").format(dateTime);
    return ChartData(dateTime, month, double.parse(data?.rate ?? "0.0"));
  }
}
