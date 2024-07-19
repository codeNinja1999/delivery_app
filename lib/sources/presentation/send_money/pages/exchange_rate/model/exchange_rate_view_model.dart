import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/repository/domain/transaction/entities/calculate_transaction/calculate_transaction_result.dart';

class ExchangeRateViewModel {
  final String exchangeRate;
  final String transferFee;
  final String senderAmount;
  final String receiverAmount;
  final String senderCurrency;
  final String receiverCurrency;
  final String totalAmountToPay;

  ExchangeRateViewModel({
    required this.exchangeRate,
    required this.transferFee,
    required this.senderAmount,
    required this.receiverAmount,
    required this.senderCurrency,
    required this.receiverCurrency,
    required this.totalAmountToPay,
  });

  factory ExchangeRateViewModel.fromRateInfo(CalculateTransactionResult calculateRate) {
    return ExchangeRateViewModel(
      exchangeRate: calculateRate.currentRate ?? "",
      transferFee: calculateRate.serviceFee ?? "",
      senderAmount: calculateRate.senderResult?.realAmount ?? "",
      receiverAmount: calculateRate.receiverResult?.realAmount ?? "",
      senderCurrency: calculateRate.senderResult?.currency?.id ?? "JPY",
      receiverCurrency: calculateRate.receiverResult?.payoutInfo?.currency?.id ?? "NPR",
      totalAmountToPay: StringUtils.formatDouble(calculateRate.totalAmountToPay),
    );
  }
}
