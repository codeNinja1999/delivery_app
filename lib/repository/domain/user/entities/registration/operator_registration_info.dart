class OperatorRegistrationInfo {
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? email;
  final String? locationId;
  final String? phoneNumber;
  final String password;
  final String confirmPassword;

  OperatorRegistrationInfo({
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.locationId,
    this.phoneNumber,
    required this.password,
    required this.confirmPassword,
  });
}
