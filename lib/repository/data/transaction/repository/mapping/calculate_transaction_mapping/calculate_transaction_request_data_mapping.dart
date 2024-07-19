import 'package:fresh_fold_delivery/repository/data/transaction/model/calculate_transaction/calculate_transaction_request_model.dart';
import 'package:fresh_fold_delivery/repository/domain/transaction/entities/calculate_transaction/calculate_transaction_info.dart';
import 'package:fresh_fold_delivery/repository/data/exchange_rate/repository/mapping/calculation_mode_mapping.dart';

extension CalculateTransactionRequestDataMapping on CalculateTransactionInfo {
  CalculateTransactionRequest toRequest() {
    final requestData = CalculateTransactionRequest(
        beneficiaryId: receiverInfo?.id ?? "",
        beneficiaryCountryCode: receiverInfo?.payoutInfo?.receivingCountry?.id,
        sendCurrencyCode: senderInfo?.currency?.id ?? "JPY",
        receiveCurrencyCode: receiverInfo?.payoutInfo?.currency?.id,
        depositMethodCode: senderInfo?.depositMode?.id ?? "",
        remittanceMethodCode: receiverInfo?.payoutInfo?.mode?.id ?? "",
        remittanceAmountMethodCode: calculationMode.value,
        includeFee: false,
        remittanceAmount: amount,
        promoCode: promotionalCode);
    return requestData;
  }
}
