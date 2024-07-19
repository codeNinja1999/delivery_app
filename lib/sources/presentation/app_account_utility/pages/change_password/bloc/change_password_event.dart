part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent {}

class OldPasswordChanged extends ChangePasswordEvent {
  final String oldPassword;
  OldPasswordChanged(this.oldPassword);
}

class NewPasswordChanged extends ChangePasswordEvent {
  final String newPassword;
  NewPasswordChanged(this.newPassword);
}

class ConfirmPasswordChanged extends ChangePasswordEvent {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);
}

class ChangedPassword extends ChangePasswordEvent {}
