part of 'add_operator_bloc.dart';

abstract class AddOperatorEvent {}

class SubmitOperator extends AddOperatorEvent {}

class FirstNameChanged extends AddOperatorEvent {
  final String firstName;
  FirstNameChanged(this.firstName);
}

class MiddleNameChanged extends AddOperatorEvent {
  final String firstName;
  MiddleNameChanged(this.firstName);
}

class LastNameChanged extends AddOperatorEvent {
  final String lastName;
  LastNameChanged(this.lastName);
}

class EmailAddressChanged extends AddOperatorEvent {
  final String emailAddress;
  EmailAddressChanged(this.emailAddress);
}

class PhoneNumberChanged extends AddOperatorEvent {
  final String phoneNumber;
  PhoneNumberChanged({required this.phoneNumber});
}

// class UpdateEmailAddress extends AddOperatorEvent {
//   final String emailAddress;

//   UpdateEmailAddress({required this.emailAddress});
// }

class PasswordChanged extends AddOperatorEvent {
  final String password;
  PasswordChanged({required this.password});
}

class ConfirmPasswordChanged extends AddOperatorEvent {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);
}
