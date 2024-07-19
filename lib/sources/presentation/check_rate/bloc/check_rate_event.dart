part of 'check_rate_bloc.dart';

abstract class CheckRateEvent {}

class GetCountry extends CheckRateEvent {}

class CalculateTransaction extends CheckRateEvent {
  final String amount;
  final CalculationMode calculationMode;
  CalculateTransaction({required this.amount, required this.calculationMode});
}

class ReceiverSelectedChanged extends CheckRateEvent {
  final bool isBeneficiarySelected;
  ReceiverSelectedChanged(this.isBeneficiarySelected);
}

class ReceivingCountrySelected extends CheckRateEvent {
  ReceivingCountrySelected(this.receivingCountry);
  final ReceivingCountry? receivingCountry;
}

class PaymentModeSelected extends CheckRateEvent {
  PaymentModeSelected(this.paymentMode);
  final PaymentMode? paymentMode;
}

class GetPayoutType extends CheckRateEvent {
  final String receivingCountry;
  GetPayoutType(this.receivingCountry);
}

