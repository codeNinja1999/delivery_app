part of 'verify_email_bloc.dart';

abstract class VerifyEmailEvent {}

class VerifyEmailAddress extends VerifyEmailEvent {}

class EmailAddressChanged extends VerifyEmailEvent {
  final String emailAddress;
  EmailAddressChanged(this.emailAddress);
}
