part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent {}

class SaveEmail extends ForgotPasswordEvent {
  final String email;

  SaveEmail({required this.email});
}

class SaveOtp extends ForgotPasswordEvent {
  final String otp;
  SaveOtp(this.otp);
}
