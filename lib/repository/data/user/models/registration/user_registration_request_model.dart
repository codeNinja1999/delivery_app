class UserRegistrationRequestModel {
  final String? firstName;
  final String? lastName;
  final String? password;
  final String? confirmPassword;
  final String? phoneCode;
  final String? phoneNumber;

  UserRegistrationRequestModel({
    this.firstName,
    this.lastName,
    this.password,
    this.confirmPassword,
    this.phoneCode,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "password": password,
        "confirm_password": confirmPassword,
        "phone_code": phoneCode,
        "phone_number": phoneNumber,
      };
}
