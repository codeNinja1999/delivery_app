part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  final String oldPassword;
  final String changePassword;
  final String confirmPassword;
  final FormStatus status;

  String? get oldPasswordValidation => (oldPassword != "") ? null : LocaleKeys.emptyErrorMessage.value;
  String? get changePasswordValidation =>
      (changePassword != "" && changePassword.length > 8 && AppRegex.password.hasMatch(changePassword))
          ? null
          : LocaleKeys.newPasswordErrorMessage.value;
  String? get confirmPasswordValidation =>
      (confirmPassword == changePassword) ? null : LocaleKeys.confirmPasswordErrorMessage.value;

  ChangePasswordInfo get makeData => _makeData();

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

  _makeData() {
    return ChangePasswordInfo(
      currentPassword: oldPassword,
      newPassword: changePassword,
      confirmPassword: confirmPassword,
    );
  }

  @override
  List<Object?> get props => [oldPassword, confirmPassword, changePassword, status];
}
