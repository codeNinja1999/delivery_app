part of 'device_verification_bloc.dart';

class DeviceVerificationState extends Equatable {
  final String? code;
  final LoginViewModel? loginViewModel;
  final Duration resendDuration;
  final FormStatus status;

  String? get verificationCodeValidation =>
      (code != null) ? null : LocaleKeys.enterSixDigitVerificationCode.value;

  DeviceVerificationState({
    this.code,
    this.loginViewModel,
    this.resendDuration = const Duration(minutes: 3),
    status,
  }) : status = (status != null) ? status : InitialStatus();

  DeviceVerificationState copyWith({
    String? code,
    LoginViewModel? loginViewModel,
    String? verificationCode,
    Duration? resendDuration,
    FormStatus? status,
  }) {
    return DeviceVerificationState(
      code: code ?? this.code,
      loginViewModel: loginViewModel ?? this.loginViewModel,
      resendDuration: resendDuration ?? this.resendDuration,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [code, loginViewModel, resendDuration, status];
}
