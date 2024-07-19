import 'calculate_mode.dart';

class RateCalculateResult {
  final String currentRate;
  final String currency;
  final String remittedAmount;
  final String estimatedReceivingAmount;
  final CalculationMode calculationMode;
  final String serviceFee;
  final String totalAmountToPay;

  RateCalculateResult(
      {required this.currentRate,
      required this.currency,
      required this.remittedAmount,
      required this.estimatedReceivingAmount,
      required this.calculationMode,
      required this.serviceFee,
      required this.totalAmountToPay});
}
