import 'package:fresh_fold_delivery/repository/domain/otp/entities/otp_issue_type.dart';
import 'package:fresh_fold_delivery/repository/domain/otp/entities/verify_by.dart';

class VerifyOTP {
  final OTPIssueType issueType;
  final VerifyBy verifyBy;
  final String verificationCode;
  final String processID;

  VerifyOTP({
    required this.processID,
    required this.verifyBy,
    required this.issueType,
    required this.verificationCode,
  });
}
