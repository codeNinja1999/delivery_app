import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/data/exchange_rate/model/exchange_rate_history_list/exchange_rate_history_list_request_model.dart';

import '../entities/entities.dart';

abstract class ExchangeRateRepository {
  Future<Either<Exception, RateCalculateResult>> calculateRate(RateCalculateInfo data);
  Future<Either<Exception, String>> getExchangeRateList();
  Future<Either<Exception, RateHistoryResult>> getExchangeRateHistoryList(ExchangeRateHistoryListRequestModel requestModel);
}
