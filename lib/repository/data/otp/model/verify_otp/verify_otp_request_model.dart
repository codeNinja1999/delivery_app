class VerifyOtpRequestModel {
  VerifyOtpRequestModel({
    this.issueType,
    this.verificationCode,
    this.processID,
  });

  String? issueType;
  String? verificationCode;
  String? processID;

  Map<String, dynamic> toJson() => {
        "issue_type": issueType ?? "",
        "verification_code": verificationCode ?? "",
        "process_id": processID ?? ""
      };
}
