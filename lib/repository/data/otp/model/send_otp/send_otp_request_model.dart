class SendOtpRequestModel {
  SendOtpRequestModel({
    this.emailAddress,
    this.mobileNumber,
    this.birthday,
    this.firstName,
    this.language,
    this.issueType,
    this.customerNo,
    this.referrerId,
  });

  String? emailAddress;
  String? mobileNumber;
  String? birthday;
  String? firstName;
  String? language;
  String? issueType;
  String? customerNo;
  String? referrerId;

  factory SendOtpRequestModel.fromJson(Map<String, dynamic> json) =>
      SendOtpRequestModel(
        emailAddress: json["email_address"],
        mobileNumber: json["mobile_number"],
        birthday: json["birthday"],
        firstName: json["first_name"],
        language: json["language"],
        issueType: json["issue_type"],
        customerNo: json["customer_no"],
        referrerId: json["referrer_id"],
      );

  Map<String, dynamic> toJson() => {
        "email_address": emailAddress ?? "",
        "mobile_number": mobileNumber ?? "",
        "birthday": birthday ?? "",
        "first_name": firstName ?? "",
        "language": language ?? "",
        "issue_type": issueType ?? "",
        "customer_no": customerNo ?? "",
        "referrer_id": referrerId ?? "",
      };
}
