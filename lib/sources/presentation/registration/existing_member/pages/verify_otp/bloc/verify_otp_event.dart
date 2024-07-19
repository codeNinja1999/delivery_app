part of 'verify_otp_bloc.dart';

abstract class VerifyOtpEvent {}

class GetVerificationType extends VerifyOtpEvent {}

class VerifyNewAccountOTP extends VerifyOtpEvent {
  final String processID;
  final String verificationCode;

  VerifyNewAccountOTP({
    required this.processID,
    required this.verificationCode,
  });
}

class ResendOtp extends VerifyOtpEvent {
  final String? sendingCountryTelCode;
  final String recipient;
  ResendOtp({
    this.sendingCountryTelCode,
    required this.recipient,
  });
}

class SecondTicked extends VerifyOtpEvent {}
