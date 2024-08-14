class RegistrationInfo {
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? phoneCode;
  final String? phoneNumber;
  final String password;
  final String confirmPassword;

  RegistrationInfo({
    this.firstName,
    this.middleName,
    this.lastName,
    this.phoneCode,
    this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });
}
