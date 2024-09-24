class UserPersonalInfo {
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? fullName;
  final String? userName;
  final String? email;
  final String? phoneCode;
  final String? phoneNumber;

  UserPersonalInfo({
    this.fullName,
    this.firstName,
    this.middleName,
    this.lastName,
    this.userName,
    this.email,
    this.phoneCode,
    this.phoneNumber,
  });
}

class EnglishName {
  final String? firstName;
  final String? middleName;
  final String? lastName;

  EnglishName({this.firstName, this.middleName, this.lastName});
}