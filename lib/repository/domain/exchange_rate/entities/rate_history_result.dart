class RateHistoryResult {
  final String? dateFilter;
  final String? country;
  final String? countryCode;
  final String? baseCurrencyCode;
  final String? counterCurrencyCode;
  final String? minValue;
  final String? maxValue;
  final String? interval;
  final List<RateHistory?>? rateHistoryList;

  RateHistoryResult({
    this.dateFilter,
    this.country,
    this.countryCode,
    this.baseCurrencyCode,
    this.counterCurrencyCode,
    this.minValue,
    this.maxValue,
    this.interval,
    this.rateHistoryList,
  });
}

class RateHistory {
  final String? date;
  final String? rate;

  RateHistory({required this.date, required this.rate});
}
