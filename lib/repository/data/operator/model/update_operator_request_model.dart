class UpdateOperatorRequestModel {
  final String? fullName;
  final String? address;
  final String? password;
  final String? confirmPassword;
  final String? emailAddress;
  final String? phoneNumber;

  UpdateOperatorRequestModel({
    this.fullName,
    this.address,
    this.password,
    this.confirmPassword,
    this.emailAddress,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "location": address,
        "password": password,
        "confirm_password": confirmPassword,
        "email_address": emailAddress,
        "phone_number": phoneNumber,
      };
}
