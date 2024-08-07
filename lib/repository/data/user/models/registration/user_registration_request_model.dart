class UserRegistrationRequestModel {
  final String? firstName;
  final String? lastName;
  final String? userName;
  final String? phoneCode;
  final String? password;
  final String? confirmPassword;
  final String? phoneNumber;
  final String? deviceAddress;
  final bool? isGuest;

  UserRegistrationRequestModel({
    this.firstName,
    this.lastName,
    this.userName,
    this.phoneCode,
    this.password,
    this.confirmPassword,
    this.phoneNumber,
    this.deviceAddress,
    this.isGuest,
  });

  UserRegistrationRequestModel copyWith({
    String? firstName,
    String? lastName,
    String? userName,
    String? phoneCode,
    String? password,
    String? confirmPassword,
    String? phoneNumber,
    String? deviceAddress,
    bool? isGuest,
  }) =>
      UserRegistrationRequestModel(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        userName: userName ?? this.userName,
        phoneCode: phoneCode ?? this.phoneCode,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        deviceAddress: deviceAddress ?? this.deviceAddress,
        isGuest: isGuest ?? this.isGuest,
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "user_name": userName,
        "phone_code": phoneCode,
        "password": password,
        "confirm_password": confirmPassword,
        "phone_number": phoneNumber,
        "device_address": deviceAddress,
        "is_guest": isGuest,
      };
}
