import 'package:fresh_fold_delivery/repository/repository.dart';

class GenerateOTP {
  final String recipient;
  final OTPIssueType issueType;
  final String? dateOfBirth;
  final String? userID;

  GenerateOTP({
    required this.recipient,
    required this.issueType,
    this.dateOfBirth,
    this.userID,
  });
}
