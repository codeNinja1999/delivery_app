import 'package:fresh_fold_delivery/repository/repository.dart';

extension VerifyOtpDataMapping on VerifyOTP {
  VerifyOtpRequestModel toRequestData() {
    return VerifyOtpRequestModel(
      issueType: issueType.value(verifyBy),
      verificationCode: verificationCode,
      processID: processID,
    );
  }
}
