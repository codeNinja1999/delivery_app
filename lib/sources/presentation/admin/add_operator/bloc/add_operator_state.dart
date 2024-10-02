part of 'add_operator_bloc.dart';

class AddOperatorState extends Equatable {
  final String firstName;
  final String middleName;
  final String lastName;
  final String address;
  final String phoneNumber;
  final String emailAddress;
  final String password;
  final String confirmPassword;
  final FormStatus status;

  AddOperatorState({
    this.firstName = "",
    this.middleName = "",
    this.lastName = "",
    this.address = "",
    this.phoneNumber = "",
    this.emailAddress = "",
    this.password = "",
    this.confirmPassword = "",
    status,
  }) : status = (status != null) ? status : InitialStatus();

  OperatorUser get getData => _makeData();

  String? get emailValidation =>
      (AppRegex.email.hasMatch(emailAddress)) || emailAddress == "" ? null : LocaleKeys.emailAddressErrorMessage.value;
  String? get passwordValidation => (AppRegex.eightDigit.hasMatch(password)) &&
          (AppRegex.oneLetterCapital.hasMatch(password)) &&
          (AppRegex.spacialAndNumeric.hasMatch(password))
      ? null
      : LocaleKeys.passwordErrorMessage.value;
  String? get confirmPasswordValidation =>
      (confirmPassword != password) ? LocaleKeys.confirmPasswordErrorMessage.value : null;
  String? get addressValidation => (address != "") ? null : LocaleKeys.addressErrorMessage.value;
  String? get phoneNumberValidation => (phoneNumber != "") ? null : LocaleKeys.phoneNumberErrorMessage.value;

  AddOperatorState copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? address,
    String? phoneNumber,
    String? emailAddress,
    String? password,
    String? confirmPassword,
    FormStatus? status,
  }) {
    final state = AddOperatorState(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? InitialStatus(),
    );
    return state;
  }

  OperatorUser _makeData() {
    return OperatorUser(
      password: password,
      confirmPassword: confirmPassword,
      personalInfo: UserPersonalInfo(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        userName: middleName != "" ? '$firstName $middleName $lastName' : '$firstName $lastName',
        fullName: middleName != "" ? '$firstName $middleName $lastName' : '$firstName $lastName',
      ),
    );
  }

  @override
  List<Object> get props => [
        firstName,
        middleName,
        lastName,
        address,
        phoneNumber,
        emailAddress,
        password,
        confirmPassword,
        status,
      ];
}
