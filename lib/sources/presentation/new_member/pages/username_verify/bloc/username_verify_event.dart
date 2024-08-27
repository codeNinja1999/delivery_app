part of 'username_verify_bloc.dart';

abstract class UsernameVerifyEvent {}

class VerifyEmailAddress extends UsernameVerifyEvent {}

class EmailAddressChanged extends UsernameVerifyEvent {
  final String emailAddress;
  EmailAddressChanged(this.emailAddress);
}
