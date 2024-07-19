part of 'exchange_rate_bloc.dart';

abstract class ExchangeRateEvent {}

class GetReceivingCountry extends ExchangeRateEvent {}

class CheckKycStatus extends ExchangeRateEvent {}

class GetTransactionListInfo extends ExchangeRateEvent {}

class UserInfoSubscription extends ExchangeRateEvent {}

class TransactionListSubscriptionRequested extends ExchangeRateEvent {}

class CalculateTransaction extends ExchangeRateEvent {
  final String amount;
  final CalculationMode calculationMode;
  final DetailedReceiver? receiver;
  CalculateTransaction({
    required this.amount,
    required this.calculationMode,
    this.receiver,
  });
}

class ShowDiscountPromoChanged extends ExchangeRateEvent {
  final bool showDiscountPromo;
  ShowDiscountPromoChanged(this.showDiscountPromo);
}

class ReceiverSelectedChanged extends ExchangeRateEvent {
  final bool isBeneficiarySelected;
  ReceiverSelectedChanged(this.isBeneficiarySelected);
}

class ReceivingCountrySelected extends ExchangeRateEvent {
  ReceivingCountrySelected(this.receivingCountry);
  final ReceivingCountry? receivingCountry;
}

class PaymentModeSelected extends ExchangeRateEvent {
  PaymentModeSelected(this.paymentMode);
  final PaymentMode? paymentMode;
}

class GetPayoutType extends ExchangeRateEvent {
  final String receivingCountry;
  GetPayoutType(this.receivingCountry);
}

class PromoCodeChanged extends ExchangeRateEvent {
  final String? promotionCode;
  PromoCodeChanged(this.promotionCode);
}
