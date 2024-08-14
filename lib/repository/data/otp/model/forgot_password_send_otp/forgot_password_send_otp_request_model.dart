class ForgotPasswordOtpRequestModel {
  final String? email;

  ForgotPasswordOtpRequestModel({this.email});

  Map<String, dynamic> toJson() => {"email": email};
}
