part of 'otp_verify_bloc.dart';

class OtpVerifyState extends Equatable {
  final String? email;
  final String verificationCode;
  final Duration resendDuration;
  final FormStatus status;

  String? get otpValidation => (verificationCode != "") ? null : LocaleKeys.userIdErrorMessage.value;

  OtpVerifyState({
    this.verificationCode = "",
    this.email,
    this.resendDuration = const Duration(minutes: 3),
    status,
  }) : status = (status != null) ? status : InitialStatus();

  OtpVerifyState copyWith({
    String? email,
    String? verificationCode,
    Duration? resendDuration,
    FormStatus? status,
  }) {
    return OtpVerifyState(
      verificationCode: verificationCode ?? this.verificationCode,
      email: email ?? this.email,
      resendDuration: resendDuration ?? this.resendDuration,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [verificationCode, email, resendDuration, status];
}
