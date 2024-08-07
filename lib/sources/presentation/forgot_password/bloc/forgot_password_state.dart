part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  final String loginId;
  final String otpVerifyProcessID;
  final String resetProcessID;
  final String resetPin;
  final bool isEmail;

  const ForgotPasswordState({
    this.loginId = "",
    this.otpVerifyProcessID = "",
    this.resetProcessID = "",
    this.resetPin = "",
    this.isEmail = true,
  });

  ForgotPasswordState copyWith({
    String? loginId,
    String? otpVerifyProcessID,
    String? resetProcessID,
    String? resetPin,
    bool? isEmail,
  }) {
    return ForgotPasswordState(
      loginId: loginId ?? this.loginId,
      otpVerifyProcessID: otpVerifyProcessID ?? this.otpVerifyProcessID,
      resetProcessID: resetProcessID ?? this.resetProcessID,
      resetPin: resetPin ?? this.resetPin,
      isEmail: isEmail ?? this.isEmail,
    );
  }

  @override
  List<Object?> get props => [loginId, otpVerifyProcessID, resetProcessID, resetPin, isEmail];

  VerifyOTP get verifyOTP => resetPasswordOtpVerify();

  VerifyOTP resetPasswordOtpVerify() {
    return VerifyOTP(
      issueType: OTPIssueType.resetTransactionPin,
      verificationCode: resetPin,
    );
  }
}
