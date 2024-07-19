part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent {}

class SaveResetOTPVerifyDetails extends ForgotPasswordEvent {
  final String loginId;
  final String processId;
  final bool isEmail;

  SaveResetOTPVerifyDetails({
    required this.loginId,
    required this.processId,
    required this.isEmail,
  });
}

class SaveResetProcessID extends ForgotPasswordEvent {
  final String resetProcessID;
  SaveResetProcessID(this.resetProcessID);
}

class SetUserPin extends ForgotPasswordEvent {
  final String pin;
  SetUserPin(this.pin);
}
