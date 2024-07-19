part of 'verify_otp_bloc.dart';

class VerifyOtpState extends Equatable {
  final String mobileNumber;
  final String? processID;
  final Duration resendDuration;
  final VerifyBy verificationType;
  final FormStatus status;

  VerifyOtpState({
    this.mobileNumber = "",
    this.processID,
    this.verificationType= VerifyBy.mobileNumber,
    this.resendDuration = const Duration(minutes: 3),
    status,
  }) : status = (status != null) ? status : InitialStatus();

  VerifyOtpState copyWith({
    String? mobileNumber,
    String? processID,
    Duration? resendDuration,
    VerifyBy? verificationType,
    FormStatus? status,
  }) {
    return VerifyOtpState(
      mobileNumber: mobileNumber ?? this.mobileNumber,
      processID: processID ?? this.processID,
      verificationType: verificationType ?? this.verificationType,
      resendDuration: resendDuration ?? this.resendDuration,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [mobileNumber, processID, verificationType, resendDuration, status];
}
