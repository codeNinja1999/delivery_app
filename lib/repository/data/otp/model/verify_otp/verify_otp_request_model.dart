class VerifyOtpRequestModel {
  final String? otp;

  VerifyOtpRequestModel({this.otp});

  Map<String, dynamic> toJson() => {"otp": otp};
}
