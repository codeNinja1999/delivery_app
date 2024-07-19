part of 'set_pin_bloc.dart';

class SetPinState extends Equatable {
  final String pin;
  final FormStatus status;
  String? get pinValidation => (pin != '')
      ? !AppRegex.pin.hasMatch(pin) && !AppRegex.pin2.hasMatch(pin) && !AppRegex.pin3.hasMatch(pin)
          ? null
          : "Weak PIN such as repeating or sequential\n number is not allowed"
      : LocaleKeys.pinErrorMessage.value;

  SetPinState({this.pin = '', status}) : status = (status != null) ? status : InitialStatus();

  SetPinState copyWith({
    String? pin,
    FormStatus? status,
  }) {
    return SetPinState(pin: pin ?? this.pin, status: status ?? this.status);
  }

  @override
  List<Object> get props => [pin, status];
}
