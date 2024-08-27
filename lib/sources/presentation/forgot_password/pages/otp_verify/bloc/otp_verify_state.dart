part of 'otp_verify_bloc.dart';

class OtpVerifyState extends Equatable {
  final String verificationCode;
  final Duration resendDuration;
  final FormStatus status;

  String? get otpValidation => (verificationCode != "") ? null : LocaleKeys.userIdErrorMessage.value;

  OtpVerifyState({
    this.verificationCode = "",
    this.resendDuration = const Duration(minutes: 3),
    status,
  }) : status = (status != null) ? status : InitialStatus();

  OtpVerifyState copyWith({
    String? verificationCode,
    Duration? resendDuration,
    FormStatus? status,
  }) {
    return OtpVerifyState(
      verificationCode: verificationCode ?? this.verificationCode,
      resendDuration: resendDuration ?? this.resendDuration,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [verificationCode, resendDuration, status];
}
