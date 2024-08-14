class SendOtpRequestModel {
  final String? role;
  final String? email;

  SendOtpRequestModel({this.role, this.email});

  Map<String, dynamic> toJson() => {"role": role, "email": email};
}
