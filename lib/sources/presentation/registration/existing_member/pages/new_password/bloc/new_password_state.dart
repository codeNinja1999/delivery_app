part of 'new_password_bloc.dart';

class NewPasswordState extends Equatable {
  final String newPassword;
  final String confirmPassword;
  final bool isSkip;
  final FormStatus status;

  String? get newPasswordValidation =>
      (newPassword != "" && newPassword.length > 8 && AppRegex.password.hasMatch(newPassword))
          ? null
          : LocaleKeys.newPasswordErrorMessage.value;
  String? get confirmPasswordValidation =>
      (confirmPassword == newPassword) ? null : LocaleKeys.confirmPasswordErrorMessage.value;

  NewPasswordState({
    this.newPassword = "",
    this.confirmPassword = "",
    this.isSkip = false,
    FormStatus? status,
  }) : status = status ?? InitialStatus();

  NewPasswordState copyWith({
    String? newPassword,
    String? confirmPassword,
    bool? isSkip,
    FormStatus? status,
  }) {
    return NewPasswordState(
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isSkip: isSkip ?? this.isSkip,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [newPassword, confirmPassword, isSkip, status];
}
