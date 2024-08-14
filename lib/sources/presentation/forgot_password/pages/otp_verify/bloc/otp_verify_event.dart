part of 'otp_verify_bloc.dart';

abstract class OtpVerifyEvent {}

class OtpCodeChanged extends OtpVerifyEvent {
  final String verificationCode;
  OtpCodeChanged(this.verificationCode);
}

class VerifyResetOTP extends OtpVerifyEvent {
  final String email;
  final String verificationCode;

  VerifyResetOTP({
    required this.email,
    required this.verificationCode,
  });
}

class ResendOtp extends OtpVerifyEvent {
  ResendOtp({required this.email});
  final String email;
}

class SecondTicked extends OtpVerifyEvent {}
