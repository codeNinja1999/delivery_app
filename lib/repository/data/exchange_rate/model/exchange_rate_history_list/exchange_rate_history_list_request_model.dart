class ExchangeRateHistoryListRequestModel {
  ExchangeRateHistoryListRequestModel({
    this.dateFilter,
    this.country,
  });

  String? dateFilter;
  String? country;

  Map<String, dynamic> toJson() => {
        "date_filter": dateFilter,
        "country": country,
      };
}
