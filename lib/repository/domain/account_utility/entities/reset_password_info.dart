class ResetPasswordInfo {
  final String newPassword;
  final String confirmPassword;
  final String email;
  final String otp;

  ResetPasswordInfo({
    required this.email,
    required this.otp,
    required this.newPassword,
    required this.confirmPassword,
  });
}
