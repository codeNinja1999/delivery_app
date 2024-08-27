part of 'account_otp_verify_bloc.dart';

abstract class AccountOtpVerifyEvent {}

class VerifyRegisterOTP extends AccountOtpVerifyEvent {}

class VerificationCodeChanged extends AccountOtpVerifyEvent {
  final String verificationCode;

  VerificationCodeChanged(this.verificationCode);
}

class ResendOtp extends AccountOtpVerifyEvent {
  final String emailAddress;
  ResendOtp({required this.emailAddress});
}

class SecondTicked extends AccountOtpVerifyEvent {}
