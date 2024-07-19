part of 'account_otp_verify_bloc.dart';

class AccountOtpVerifyState extends Equatable {
  final String mobileNumber;
  final String? processID;
  final Duration resendDuration;
  final FormStatus status;

  AccountOtpVerifyState({
    this.mobileNumber = "",
    this.processID,
    this.resendDuration = const Duration(minutes: 3),
    status,
  }) : status = (status != null) ? status : InitialStatus();

  AccountOtpVerifyState copyWith({
    String? mobileNumber,
    String? processID,
    Duration? resendDuration,
    FormStatus? status,
  }) {
    return AccountOtpVerifyState(
      mobileNumber: mobileNumber ?? this.mobileNumber,
      processID: processID ?? this.processID,
      resendDuration: resendDuration ?? this.resendDuration,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [mobileNumber, processID, resendDuration, status];
}
