part of 'edit_profile_bloc.dart';

class EditProfileState extends Equatable {
  final String firstName;
  final String middleName;
  final String lastName;
  final String userName;
  final String phoneNumber;
  final String houseNumber;
  final String additionalInformation;
  final FormStatus status;

  User get data => _makeData();

  String? get firstNameValidation => (firstName != "") ? null : LocaleKeys.firstNameErrorMessage.value;
  String? get lastNameValidation => (lastName != "") ? null : LocaleKeys.lastNameErrorMessage.value;
  String? get userNameValidation => (userName != "") ? null : LocaleKeys.userNameErrorMessage.value;
  String? get phoneNumberValidation => (phoneNumber != "") ? null : LocaleKeys.phoneNumberErrorMessage.value;
  String? get houseNumberValidation => (houseNumber != "") ? null : LocaleKeys.houseNumberErrorMessage.value;

  EditProfileState({
    this.firstName = "",
    this.middleName = "",
    this.lastName = "",
    this.userName = "",
    this.phoneNumber = "",
    this.houseNumber = "",
    this.additionalInformation = "",
    FormStatus? status,
  }) : status = status ?? InitialStatus();

  EditProfileState copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? userName,
    String? phoneNumber,
    String? houseNumber,
    String? additionalInformation,
    FormStatus? status,
  }) {
    return EditProfileState(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      houseNumber: houseNumber ?? this.houseNumber,
      additionalInformation: additionalInformation ?? this.additionalInformation,
      status: status ?? this.status,
    );
  }

  _makeData() {
    return User(
      personalInfo: UserPersonalInfo(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        userName: userName,
      ),
      contactInfo: UserContactInfo(houseNumber: houseNumber),
      additionalInformation: additionalInformation,
    );
  }

  @override
  List<Object> get props => [
        firstName,
        middleName,
        lastName,
        userName,
        phoneNumber,
        houseNumber,
        additionalInformation,
        status,
      ];
}
