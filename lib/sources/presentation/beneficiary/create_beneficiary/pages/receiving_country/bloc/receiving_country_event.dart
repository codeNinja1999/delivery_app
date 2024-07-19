part of 'receiving_country_bloc.dart';

abstract class ReceivingCountryEvent {}

class GetReceivingCountry extends ReceivingCountryEvent {}

class ReceivingCountrySelected extends ReceivingCountryEvent {
  ReceivingCountrySelected(this.receivingCountry);
  final ReceivingCountry receivingCountry;
}

class ValidateReceivingCountry extends ReceivingCountryEvent {}

class PayoutTypeSelected extends ReceivingCountryEvent {
  PayoutTypeSelected({required this.payoutType});
  final PaymentMode payoutType;
}

class GetPayoutType extends ReceivingCountryEvent {
  final String receivingCountry;
  GetPayoutType(this.receivingCountry);
}


class TogglePaymentMethodDialog extends ReceivingCountryEvent {}