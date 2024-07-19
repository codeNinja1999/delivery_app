part of 'set_pin_bloc.dart';

abstract class SetPinEvent {}

class PinChanged extends SetPinEvent {
  PinChanged(this.pin);
  final String pin;
}
