part of 'account_otp_verify_bloc.dart';

abstract class AccountOtpVerifyEvent {}

class VerifyNewAccountOTP extends AccountOtpVerifyEvent {
  final String processID;
  final String verificationCode;
  final VerifyBy verifyBy;

  VerifyNewAccountOTP({
    required this.processID,
    required this.verificationCode,
    required this.verifyBy,
  });
}

class ResendOtp extends AccountOtpVerifyEvent {
  final String? sendingCountryTelCode;
  final String recipient;
  final bool isEmail;
  ResendOtp({
    this.sendingCountryTelCode,
    required this.recipient,
    required this.isEmail,
  });
}

class SecondTicked extends AccountOtpVerifyEvent {}
