import 'package:fresh_fold_delivery/repository/domain/otp/entities/otp_issue_type.dart';

class VerifyOTP {
  final OTPIssueType issueType;
  final String verificationCode;

  VerifyOTP({
    required this.issueType,
    required this.verificationCode,
  });
}
