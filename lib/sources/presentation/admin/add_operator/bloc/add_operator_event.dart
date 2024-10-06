part of 'add_operator_bloc.dart';

abstract class AddOperatorEvent {}

class SubmitOperator extends AddOperatorEvent {}

class GetOperator extends AddOperatorEvent {}

class FullNameChanged extends AddOperatorEvent {
  final String fullName;
  FullNameChanged(this.fullName);
}

class EmailAddressChanged extends AddOperatorEvent {
  final String emailAddress;
  EmailAddressChanged(this.emailAddress);
}

class PhoneNumberChanged extends AddOperatorEvent {
  final String phoneNumber;
  PhoneNumberChanged({required this.phoneNumber});
}

class PasswordChanged extends AddOperatorEvent {
  final String password;
  PasswordChanged({required this.password});
}

class ConfirmPasswordChanged extends AddOperatorEvent {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);
}
