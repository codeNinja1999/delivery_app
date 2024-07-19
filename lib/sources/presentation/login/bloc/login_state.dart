part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String username;
  final String password;
  final bool isRememberMe;
  final FormStatus status;
  final String changeLanguage;
  final String persistUsername;
  final bool shouldVerifyDevice;
  final LoginViewModel? loginViewModel;

  String? get usernameValidation =>
      (username != "") ? null : LocaleKeys.userIdErrorMessage.value;
  String? get passwordValidation =>
      (password != "") ? null : LocaleKeys.passwordErrorMessage.value;

  LoginState({
    this.persistUsername = '',
    this.username = '',
    this.password = '',
    this.changeLanguage = "",
    this.isRememberMe = false,
    this.shouldVerifyDevice = false,
    this.loginViewModel,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  LoginState copyWith({
    String? persistUsername,
    String? username,
    String? password,
    String? changeLanguage,
    bool? isRememberMe,
    bool? isTermConfirmed,
    bool? shouldVerifyDevice,
    LoginViewModel? loginViewModel,
    FormStatus? status,
  }) {
    return LoginState(
      persistUsername: persistUsername ?? this.persistUsername,
      username: username ?? this.username,
      password: password ?? this.password,
      shouldVerifyDevice: shouldVerifyDevice ?? false,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      loginViewModel: loginViewModel ?? this.loginViewModel,
      changeLanguage: changeLanguage ?? this.changeLanguage,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [
        persistUsername,
        username,
        password,
        status,
        shouldVerifyDevice,
        changeLanguage,
        isRememberMe,
      ];
}
