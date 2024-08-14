class ResetPasswordRequestModel {
  final String? email;
  final String? otp;
  final String? password;
  final String? confirmPassword;

  ResetPasswordRequestModel({this.email, this.otp, this.password, this.confirmPassword});

  Map<String, dynamic> toJson() => {"email": email, "otp": otp, "password": password, "confirm_password": confirmPassword};
}
