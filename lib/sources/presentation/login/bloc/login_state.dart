part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String username;
  final String password;
  final bool isRememberMe;
  final FormStatus status;
  final String persistUsername;

  String? get usernameValidation =>
      (AppRegex.email.hasMatch(username) && username != "") ? null : LocaleKeys.emailAddressErrorMessage.value;
  String? get passwordValidation => (password != "") ? null : LocaleKeys.passwordErrorMessage.value;

  LoginState({
    this.persistUsername = '',
    this.username = '',
    this.password = '',
    this.isRememberMe = false,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  LoginState copyWith({
    String? persistUsername,
    String? username,
    String? password,
    bool? isRememberMe,
    FormStatus? status,
  }) {
    return LoginState(
      persistUsername: persistUsername ?? this.persistUsername,
      username: username ?? this.username,
      password: password ?? this.password,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [
        persistUsername,
        username,
        password,
        status,
        isRememberMe,
      ];
}
