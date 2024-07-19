part of 'device_verification_bloc.dart';

class DeviceVerificationEvent {
  const DeviceVerificationEvent();
}

class VerifyDevice extends DeviceVerificationEvent {}

class RetryLogin extends DeviceVerificationEvent {
  RetryLogin();
}

class VerificationCodeChanged extends DeviceVerificationEvent {
  final String code;

  VerificationCodeChanged(this.code);
}

class SecondTicked extends DeviceVerificationEvent {}
