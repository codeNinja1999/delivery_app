class VerifyOtpResponseModel {
  final String? message;

  VerifyOtpResponseModel({this.message});

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) => VerifyOtpResponseModel(
        message: json["message"],
      );
}
