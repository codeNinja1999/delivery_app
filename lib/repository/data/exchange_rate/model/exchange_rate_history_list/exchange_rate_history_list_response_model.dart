class ExchangeRateHistoryListResponseModel {
  final List<ResultList>? resultList;
  final dynamic dateFilter;
  final String? country;
  final String? countryCode;
  final String? baseCurrencyCode;
  final String? counterCurrencyCode;
  final String? minValue;
  final String? maxValue;
  final String? interval;
  final bool? processResult;
  final List<dynamic>? warningList;
  final List<dynamic>? errorList;

  ExchangeRateHistoryListResponseModel({
    this.resultList,
    this.dateFilter,
    this.country,
    this.countryCode,
    this.baseCurrencyCode,
    this.counterCurrencyCode,
    this.minValue,
    this.maxValue,
    this.interval,
    this.processResult,
    this.warningList,
    this.errorList,
  });

  factory ExchangeRateHistoryListResponseModel.fromJson(Map<String, dynamic> json) =>
      ExchangeRateHistoryListResponseModel(
        resultList: json["result_list"] == null
            ? []
            : List<ResultList>.from(json["result_list"]!.map((x) => ResultList.fromJson(x))),
        dateFilter: json["date_filter"],
        country: json["country"],
        countryCode: json["country_code"],
        baseCurrencyCode: json["base_currency_code"],
        counterCurrencyCode: json["counter_currency_code"],
        minValue: json["min_value"],
        maxValue: json["max_value"],
        interval: json["interval"],
        processResult: json["process_result"],
        warningList: json["warning_list"] == null ? [] : List<dynamic>.from(json["warning_list"]!.map((x) => x)),
        errorList: json["error_list"] == null ? [] : List<dynamic>.from(json["error_list"]!.map((x) => x)),
      );
}

class ResultList {
  final String? country;
  final String? baseCurrencyCode;
  final String? counterCurrencyCode;
  final String? rate;
  final String? updateDate;

  ResultList({
    this.country,
    this.baseCurrencyCode,
    this.counterCurrencyCode,
    this.rate,
    this.updateDate,
  });

  factory ResultList.fromJson(Map<String, dynamic> json) => ResultList(
        country: json["country"],
        baseCurrencyCode: json["base_currency_code"],
        counterCurrencyCode: json["counter_currency_code"],
        rate: json["rate"],
        updateDate: json["update_date"],
      );


  Map<String, dynamic> toJson() => {
        "country": country,
        "base_currency_code": baseCurrencyCode,
        "counter_currency_code": counterCurrencyCode,
        "rate": rate,
        "update_date": updateDate,
      };
}
