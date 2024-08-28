class VerifyOtpRequestModel {
  final int? otp;

  VerifyOtpRequestModel({this.otp});

  Map<String, dynamic> toJson() => {"otp": otp};
}
