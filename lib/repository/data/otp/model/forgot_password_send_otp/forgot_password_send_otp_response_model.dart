class ForgotPasswordOtpResponseModel {
  final String? message;

  ForgotPasswordOtpResponseModel({this.message});

  factory ForgotPasswordOtpResponseModel.fromJson(Map<String, dynamic> json) => ForgotPasswordOtpResponseModel(
        message: json["message"],
      );
}
