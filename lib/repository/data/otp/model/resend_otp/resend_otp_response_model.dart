class ResendOtpResponseModel {
  final String? message;

  ResendOtpResponseModel({this.message});

  factory ResendOtpResponseModel.fromJson(Map<String, dynamic> json) => ResendOtpResponseModel(
        message: json["message"],
      );
}
