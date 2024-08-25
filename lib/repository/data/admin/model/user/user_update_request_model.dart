class UserUpdateRequestModel {
  final String? email;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? userName;
  final String? phoneNumber;
  final String? password;
  final String? confirmPassword;
  final int? locationId;

  UserUpdateRequestModel({
    this.email,
    this.firstName,
    this.middleName,
    this.lastName,
    this.userName,
    this.phoneNumber,
    this.password,
    this.confirmPassword,
    this.locationId,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "user_name": userName,
        "phone_number": phoneNumber,
        "password": password,
        "confirm_password": confirmPassword,
        "location_id": locationId,
      };
}
