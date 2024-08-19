class ForgotPasswordVerifyOtpResponseModel {
  final String? message;

  ForgotPasswordVerifyOtpResponseModel({this.message});

  factory ForgotPasswordVerifyOtpResponseModel.fromJson(Map<String, dynamic> json) => ForgotPasswordVerifyOtpResponseModel(
        message: json["message"],
      );
}
