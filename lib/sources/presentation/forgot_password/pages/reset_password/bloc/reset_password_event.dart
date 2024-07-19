part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent {}

class NewPasswordChanged extends ResetPasswordEvent {
  final String newPassword;
  NewPasswordChanged(this.newPassword);
}

class ConfirmPasswordChanged extends ResetPasswordEvent {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);
}

class SetPassword extends ResetPasswordEvent {
  final String processID;
  final String confirmPassword;
  SetPassword({required this.processID, required this.confirmPassword});
}
