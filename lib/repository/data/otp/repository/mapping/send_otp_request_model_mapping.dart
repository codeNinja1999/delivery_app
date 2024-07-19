import 'package:fresh_fold_delivery/repository/repository.dart';

extension SendOtpRequestDataMapping on GenerateOTP {
  SendOtpRequestModel toRequestData() {
    return SendOtpRequestModel(
      mobileNumber: verifyBy == VerifyBy.mobileNumber ? recipient : "",
      emailAddress: verifyBy == VerifyBy.email ? recipient : "",
      issueType: issueType.value(verifyBy),
      birthday: dateOfBirth,
      language: "en",
      customerNo: userID,
    );
  }
}
