part of 'change_password_bloc.dart';

class ChangePasswordState {
  String oldPassword;
  String changePassword;
  String confirmPassword;
  FormStatus status;

  String? get oldPasswordValidation => (oldPassword != "") ? null : LocaleKeys.emptyErrorMessage.value;
  String? get changePasswordValidation =>
      (changePassword != "" && changePassword.length > 8 && AppRegex.password.hasMatch(changePassword))
          ? null
          : LocaleKeys.newPasswordErrorMessage.value;
  String? get confirmPasswordValidation =>
      (confirmPassword == changePassword) ? null : LocaleKeys.confirmPasswordErrorMessage.value;

  ChangePasswordState({
    this.oldPassword = "",
    this.changePassword = "",
    this.confirmPassword = "",
    status,
  }) : status = (status != null) ? status : InitialStatus();

  ChangePasswordState copyWith({
    String? oldPassword,
    String? changePassword,
    String? confirmPassword,
    FormStatus? status,
  }) {
    return ChangePasswordState(
      oldPassword: oldPassword ?? this.oldPassword,
      changePassword: changePassword ?? this.changePassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? InitialStatus(),
    );
  }
}
