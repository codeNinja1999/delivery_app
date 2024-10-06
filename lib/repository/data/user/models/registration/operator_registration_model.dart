class OperatorRegistrationRequestModel {
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? email;
  final String? userName;
  final String? password;
  final String? confirmPassword;
  final String? locationId;
  final String? phoneNumber;

  OperatorRegistrationRequestModel({
    this.firstName,
    this.middleName,
    this.lastName,
    this.password,
    this.confirmPassword,
    this.email,
    this.userName,
    this.locationId,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "password": password,
        "email": email,
        "user_name": userName,
        "confirm_password": confirmPassword,
        "assigned_location_id": locationId,
        "phone_number": phoneNumber,
      };
}
