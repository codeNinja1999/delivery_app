part of 'add_operator_bloc.dart';

class AddOperatorState extends Equatable {
  final String fullName;
  final String phoneNumber;
  final String emailAddress;
  final String password;
  final String confirmPassword;
  final FormStatus status;

  AddOperatorState({
    this.fullName = "",
    this.phoneNumber = "",
    this.emailAddress = "",
    this.password = "",
    this.confirmPassword = "",
    status,
  }) : status = (status != null) ? status : InitialStatus();

  OperatorRegistrationInfo get getData => _makeData();

  String? get emailValidation =>
      (AppRegex.email.hasMatch(emailAddress)) || emailAddress == "" ? null : LocaleKeys.emailAddressErrorMessage.value;
  String? get passwordValidation => (AppRegex.eightDigit.hasMatch(password)) &&
          (AppRegex.oneLetterCapital.hasMatch(password)) &&
          (AppRegex.spacialAndNumeric.hasMatch(password))
      ? null
      : LocaleKeys.passwordErrorMessage.value;
  String? get confirmPasswordValidation =>
      (confirmPassword != password) ? LocaleKeys.confirmPasswordErrorMessage.value : null;
  String? get fullNameValidation => (fullName != "") ? null : LocaleKeys.fullNameErrorMessage.value;
  String? get phoneNumberValidation => (phoneNumber != "") ? null : LocaleKeys.phoneNumberErrorMessage.value;

  AddOperatorState copyWith({
    String? fullName,
    String? userName,
    String? phoneNumber,
    String? emailAddress,
    String? password,
    String? confirmPassword,
    FormStatus? status,
  }) {
    final state = AddOperatorState(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? InitialStatus(),
    );
    return state;
  }

  OperatorRegistrationInfo _makeData() {
    List<String> nameParts = fullName.trim().split(" ");
    String? firstName = "";
    String? middleName = "";
    String? lastName = "";

    if (nameParts.length == 1) {
      firstName = fullName;
    } else if (nameParts.length == 2) {
      firstName = nameParts[0];
      lastName = nameParts[1];
    } else if (nameParts.length >= 3) {
      firstName = nameParts[0];
      middleName = nameParts.sublist(1, nameParts.length - 1).join(' ');
      lastName = nameParts.last;
    }
    return OperatorRegistrationInfo(
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      email: emailAddress,
      phoneNumber: phoneNumber,
      password: password,
      confirmPassword: confirmPassword,
    );
  }

  @override
  List<Object> get props => [
        fullName,
        phoneNumber,
        emailAddress,
        password,
        confirmPassword,
        status,
      ];
}
