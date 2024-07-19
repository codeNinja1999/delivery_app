import 'package:fresh_fold_delivery/repository/data/transaction/model/calculate_transaction/calculate_transaction_response_model.dart';

import '../../../../../domain/domain.dart';

extension CalculateTransactionResponseDataMapping on CalculateTransactionResponse {
  CalculateTransactionResult toDomain(CalculateTransactionInfo info) {
    final actualFeeAmount = info.promotionalCode != "" ? serviceChargeAfterPromo : remittanceFee;
    final actualTotalToPayAmount = info.promotionalCode != "" ? remittanceAmountAfterPromo : totalAmount;

    final responseData = CalculateTransactionResult(
        senderResult: TransactionSenderResult(
            country: info.senderInfo?.country,
            currency: Catalog(id: counterCurrency ?? "", value: counterCurrency ?? ""),
            depositMode: info.senderInfo?.depositMode,
            realAmount: remittanceAmount),
        receiverResult: TransactionReceiverResult(
          id: info.receiverInfo?.id,
          payoutInfo: DetailedReceiverPayoutInfo(
            id: "",
            currency: Catalog(id: receivingCurrencyCode ?? "", value: receivingCurrencyCode ?? ""),
            mode: info.receiverInfo?.payoutInfo?.mode,
            receivingCountry: info.receiverInfo?.payoutInfo?.receivingCountry,
          ),
          realAmount: estimatedReceivingAmount,
        ),
        calculationMode: info.calculationMode,
        serviceFee: "$actualFeeAmount",
        discountFee: bonusAmt,
        totalAmountToPay: "$actualTotalToPayAmount",
        currentRate: exchangeRate ?? "",
        balance: accountBalance,
        taxAmount: taxAmount);
    return responseData;
  }
}
