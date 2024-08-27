part of 'account_otp_verify_bloc.dart';

class AccountOtpVerifyState extends Equatable {
  final String verificationCode;
  final Duration resendDuration;
  final FormStatus status;

  AccountOtpVerifyState({
    this.verificationCode="",
    this.resendDuration = const Duration(minutes: 3),
    status,
  }) : status = (status != null) ? status : InitialStatus();

  AccountOtpVerifyState copyWith({
    String? verificationCode,
    Duration? resendDuration,
    FormStatus? status,
  }) {
    return AccountOtpVerifyState(
      verificationCode: verificationCode ?? this.verificationCode,
      resendDuration: resendDuration ?? this.resendDuration,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [verificationCode, resendDuration, status];
}
