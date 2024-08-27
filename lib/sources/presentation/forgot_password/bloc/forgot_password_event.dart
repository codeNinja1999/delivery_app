part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent {}

class SaveEmail extends ForgotPasswordEvent {
  final String emailAddress;

  SaveEmail(this.emailAddress);
}
