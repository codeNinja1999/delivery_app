import 'package:fresh_fold_delivery/repository/data/exchange_rate/model/exchange_rate/exchange_rate_response_model.dart';

import '../../../../domain/exchange_rate/exchange_rate.dart';

extension ExchangeRateResponseMapping on ExchangeRateResponseModel {
  RateCalculateResult toDomain(CalculationMode calculationMode) {
    return RateCalculateResult(
      currentRate: exchangeRate ?? "",
      currency: receivingCurrencyCode ?? "",
      remittedAmount: remittanceAmount ?? "",
      estimatedReceivingAmount: estimatedReceivingAmount ?? "",
      calculationMode: calculationMode,
      serviceFee: "$remittanceFee",
      totalAmountToPay: totalAmount ?? "",
    );
  }
}
