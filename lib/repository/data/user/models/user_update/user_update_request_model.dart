class UpdateProfileRequestModel {
  final String? firstName;
  final String? lastName;
  final String? phoneCode;
  final String? phoneNumber;
  final String? houseNumber;
  final String? additionalInformation;

  UpdateProfileRequestModel({
    this.firstName,
    this.lastName,
    this.phoneCode,
    this.phoneNumber,
    this.houseNumber,
    this.additionalInformation,
  });

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "phone_code": phoneCode,
        "phone_number": phoneNumber,
        "house_number": houseNumber,
        "additional_information": additionalInformation,
      };
}
