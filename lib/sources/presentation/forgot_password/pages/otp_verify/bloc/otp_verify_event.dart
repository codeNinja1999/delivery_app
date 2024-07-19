part of 'otp_verify_bloc.dart';

abstract class OtpVerifyEvent {}

class OtpCodeChanged extends OtpVerifyEvent {
  final String verificationCode;
  OtpCodeChanged(this.verificationCode);
}

class VerifyResetOTP extends OtpVerifyEvent {
  final String processID;
  final String verificationCode;
  final bool isEmail;

  VerifyResetOTP({
    required this.processID,
    required this.verificationCode,
    required this.isEmail,
  });
}

class ResendOtp extends OtpVerifyEvent {
  ResendOtp({
    this.sendingCountryTelCode,
    required this.recepient,
    required this.isEmail,
  });
  final String? sendingCountryTelCode;
  final String recepient;
  final bool isEmail;
}

class SecondTicked extends OtpVerifyEvent {}
