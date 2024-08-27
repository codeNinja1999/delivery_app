part of 'otp_verify_bloc.dart';

abstract class OtpVerifyEvent {}

class OtpCodeChanged extends OtpVerifyEvent {
  final String verificationCode;
  OtpCodeChanged(this.verificationCode);
}

class VerificationCodeChanged extends OtpVerifyEvent {
  final String verificationCode;

  VerificationCodeChanged(this.verificationCode);
}

class VerifyResetOTP extends OtpVerifyEvent {}

class ResendOtp extends OtpVerifyEvent {
  ResendOtp(this.emailAddress);
  final String emailAddress;
}

class SecondTicked extends OtpVerifyEvent {}
