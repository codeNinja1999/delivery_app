class SendOtpResponseModel {
  SendOtpResponseModel({
    this.processId,
    this.verificationCode,
  });

  String? processId;
  String? verificationCode;

  factory SendOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      SendOtpResponseModel(
          processId: json["process_id"],
          verificationCode: json["verification_code"]);
}
