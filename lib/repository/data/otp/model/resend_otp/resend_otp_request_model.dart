class ResendOtpRequestModel {
  final String? email;
  final String? type;

  ResendOtpRequestModel({this.email, this.type});

  Map<String, dynamic> toJson() => {"email": email, "type": type};
}
