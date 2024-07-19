import 'package:fresh_fold_delivery/repository/data/exchange_rate/model/exchange_rate_history_list/exchange_rate_history_list_response_model.dart';

import '../../../../domain/exchange_rate/exchange_rate.dart';

extension ExchangeRateHistoryResponseMapping on ExchangeRateHistoryListResponseModel {
  RateHistoryResult toDomain() {
    return RateHistoryResult(
      dateFilter: dateFilter,
      country: country,
      rateHistoryList:
          (resultList != []) ? resultList?.map((e) => RateHistory(date: e.updateDate, rate: e.rate)).toList() : [],
      countryCode: countryCode,
      baseCurrencyCode: baseCurrencyCode,
      counterCurrencyCode: counterCurrencyCode,
      maxValue: maxValue,
      minValue: minValue,
      interval: interval,
    );
  }
}
