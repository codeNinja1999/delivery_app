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
  final String otp;
  final String email;
  final String confirmPassword;
  SetPassword({required this.otp, required this.email, required this.confirmPassword});
}
