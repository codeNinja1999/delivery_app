import 'package:fresh_fold_delivery/repository/data/exchange_rate/model/exchange_rate/exchange_rate_request_model.dart';
import 'package:fresh_fold_delivery/repository/data/exchange_rate/repository/mapping/calculation_mode_mapping.dart';

import '../../../../domain/exchange_rate/exchange_rate.dart';

extension ExchangeRateRequestDataMapping on RateCalculateInfo {
  ExchangeRateRequestModel toRequestData() {
    final requestData = ExchangeRateRequestModel(
      customerId: "",
      beneficiaryCountryCode: baseInfo.country.id,
      receiveCurrencyCode: baseInfo.currency.id,
      remittanceMethodCode: "",
      remittanceAmountMethodCode: calculationMode.value,
      remittanceAmount: amount,
      includeFee: includeFee,
    );
    return requestData;
  }
}
