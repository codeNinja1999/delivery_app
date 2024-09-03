part of 'checkout_bloc.dart';

abstract class CheckoutEvent {}

class CreateOrder extends CheckoutEvent {
  final PickupOrder pickupOrder;
  CreateOrder(this.pickupOrder);
}
