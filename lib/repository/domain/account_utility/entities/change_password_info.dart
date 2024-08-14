class ChangePasswordInfo {
  final String currentPassword;
  final String confirmPassword;
  final String newPassword;

  ChangePasswordInfo({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });
}
