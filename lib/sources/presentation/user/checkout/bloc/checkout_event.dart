part of 'checkout_bloc.dart';

abstract class CheckoutEvent {}

class GetLocalImage extends CheckoutEvent {
  final ScanBy scanBy;
  GetLocalImage(this.scanBy);
}

class PaymentTypeSelected extends CheckoutEvent {
  final PaymentType selectedPaymentType;
  PaymentTypeSelected(this.selectedPaymentType);
}

class CreateOrder extends CheckoutEvent {
  final PickupOrder pickupOrder;
  CreateOrder(this.pickupOrder);
}
