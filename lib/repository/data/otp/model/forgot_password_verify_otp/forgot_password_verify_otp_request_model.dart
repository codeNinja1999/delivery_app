class ForgotPasswordVerifyOtpRequestModel {
  final String? email;
  final int? otp;

  ForgotPasswordVerifyOtpRequestModel({this.email, this.otp});

  Map<String, dynamic> toJson() => {"email": email, "otp": otp};
}
