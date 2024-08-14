part of 'register_form_bloc.dart';

class RegisterFormState extends Equatable {
  final String fullName;
  final String password;
  final String confirmPassword;
  final String mobileNumber;
  final bool isEightCharacterValid;
  final bool isUpperCaseValid;
  final bool isNumericalValueValid;
  final FormStatus status;

  String? get fullNameValidation {
    List<String> nameParts = fullName.trim().split(" ");
    if (fullName.isNotEmpty && nameParts.length >= 2) {
      return null;
    } else {
      return LocaleKeys.fullNameErrorMessage.value;
    }
  }

  String? get phoneNumberValidation =>
      (AppRegex.mobileNumber.hasMatch(mobileNumber)) ? null : LocaleKeys.phoneNumberErrorMessage.value;

  String? get passwordValidation => (AppRegex.eightDigit.hasMatch(password) &&
          AppRegex.oneLetterCapital.hasMatch(password) &&
          AppRegex.spacialAndNumeric.hasMatch(password))
      ? null
      : LocaleKeys.passwordErrorMessage.value;
  String? get confirmPasswordValidation =>
      (confirmPassword == password) ? null : LocaleKeys.confirmPasswordErrorMessage.value;

  RegistrationInfo get makeRegistrationInfo => _makeRegistrationInfo();

  RegisterFormState({
    this.fullName = "",
    this.password = "",
    this.mobileNumber = "",
    this.confirmPassword = "",
    this.isEightCharacterValid = false,
    this.isUpperCaseValid = false,
    this.isNumericalValueValid = false,
    FormStatus? status,
  }) : status = status ?? InitialStatus();

  RegisterFormState copyWith({
    String? fullName,
    String? password,
    String? email,
    String? mobileNumber,
    String? confirmPassword,
    bool? isEightCharacterValid,
    bool? isUpperCaseValid,
    bool? isNumericalValueValid,
    FormStatus? status,
  }) {
    return RegisterFormState(
      mobileNumber: mobileNumber ?? this.mobileNumber,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isEightCharacterValid: isEightCharacterValid ?? this.isEightCharacterValid,
      isUpperCaseValid: isUpperCaseValid ?? this.isUpperCaseValid,
      isNumericalValueValid: isNumericalValueValid ?? this.isNumericalValueValid,
      status: status ?? this.status,
    );
  }

  RegistrationInfo _makeRegistrationInfo() {
    final nameParts = fullName.trim().split(' ');
    final firstName = nameParts.first;
    final lastName = nameParts.last;
    final middleName = nameParts.length > 2 ? nameParts.sublist(1, nameParts.length - 1).join(' ') : '';

    return RegistrationInfo(
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      password: password,
      confirmPassword: confirmPassword,
      phoneCode: "60",
      phoneNumber: mobileNumber,
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        mobileNumber,
        password,
        isEightCharacterValid,
        isUpperCaseValid,
        isNumericalValueValid,
        status,
      ];
}
