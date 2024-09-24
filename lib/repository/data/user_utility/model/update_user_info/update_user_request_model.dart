class UserUpdateRequestModel {
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? userName;
  final String? phoneCode;
  final String? phoneNumber;
  final String? houseNumber;
  final String? additionalInformation;

  UserUpdateRequestModel({
    this.firstName,
    this.middleName,
    this.lastName,
    this.userName,
    this.phoneCode,
    this.phoneNumber,
    this.houseNumber,
    this.additionalInformation,
  });

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "user_name": userName,
        "phone_code": phoneCode,
        "phone_number": phoneNumber,
        "house_number": houseNumber,
        "additional_information": additionalInformation,
      };
}
