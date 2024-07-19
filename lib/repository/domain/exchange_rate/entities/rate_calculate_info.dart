import 'entities.dart';

class RateCalculateInfo {
  final RateCalculateSourceInfo baseInfo;
  final CalculationMode calculationMode;
  final String amount;
  final bool includeFee;

  RateCalculateInfo({
    required this.baseInfo,
    required this.calculationMode,
    required this.amount,
    includeFee,
  }) : includeFee = (includeFee != null) ? includeFee : false;
}
