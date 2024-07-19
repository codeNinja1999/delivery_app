part of 'new_password_bloc.dart';

class NewPasswordEvent {}

class NewPasswordChanged extends NewPasswordEvent {
  NewPasswordChanged(this.newPassword);
  final String newPassword;
}

class IsSkipChanged extends NewPasswordEvent {}

class ConfirmPasswordChanged extends NewPasswordEvent {
  ConfirmPasswordChanged(this.confirmPassword);
  final String confirmPassword;
}

class UpdateExistingMember extends NewPasswordEvent {
  UpdateExistingMember({
    this.customerProcessId,
    this.profileImage,
    this.customerId,
    this.emailProcessId,
  });
  final String? customerProcessId;
  final String? emailProcessId;
  final String? profileImage;
  final String? customerId;
}
