part of 'reset_password_bloc.dart';

class ResetPasswordState {
  String newPassword;
  String confirmPassword;
  FormStatus status;
  String? get changePasswordValidation =>
      (newPassword != "" && newPassword.length >= 8 && AppRegex.password.hasMatch(newPassword))
          ? null
          : LocaleKeys.newPasswordErrorMessage.value;

  String? get confirmPasswordValidation =>
      (confirmPassword == newPassword) ? null : LocaleKeys.confirmPasswordErrorMessage.value;

  ResetPasswordState({this.newPassword = '', this.confirmPassword = '', status})
      : status = (status != null) ? status : InitialStatus();

  ResetPasswordState copyWith({
    String? newPassword,
    String? confirmPassword,
    FormStatus? status,
  }) {
    return ResetPasswordState(
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
    );
  }
}
