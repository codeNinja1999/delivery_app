part of 'update_operator_bloc.dart';

class UpdateOperatorState extends Equatable {
  final String fullName;
  final String address;
  final String phoneNumber;
  final String emailAddress;
  final String password;
  final String confirmPassword;
  final FormStatus status;

  String? get fullNameValidation {
    List<String> nameParts = fullName.trim().split(" ");
    if (fullName != "" && nameParts.length >= 2) {
      return null;
    } else {
      return LocaleKeys.fullNameErrorMessage.value;
    }
  }

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

  UpdateOperatorState({
    this.fullName = "",
    this.address = "",
    this.phoneNumber = "",
    this.emailAddress = "",
    this.password = "",
    this.confirmPassword = "",
    status,
  }) : status = (status != null) ? status : InitialStatus();

  UpdateOperatorState copyWith({
    String? fullName,
    String? phoneNumber,
    String? emailAddress,
    String? address,
    String? password,
    FormStatus? status,
  }) {
    final state = UpdateOperatorState(
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      status: status ?? InitialStatus(),
    );
    return state;
  }

  @override
  List<Object> get props => [fullName, emailAddress, address, phoneNumber, password, confirmPassword];
}
