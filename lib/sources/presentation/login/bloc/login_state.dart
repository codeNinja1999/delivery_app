part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String username;
  final String password;
  final bool isRememberMe;
  final FormStatus status;
  final Catalog userType;
  final String persistUsername;

  String? get usernameValidation =>
      (AppRegex.email.hasMatch(username) && username != "") ? null : LocaleKeys.emailAddressErrorMessage.value;
  String? get passwordValidation => (password != "") ? null : LocaleKeys.passwordErrorMessage.value;
  LoginInfo get makeData => _makeData();

  LoginState({
    this.persistUsername = '',
    this.username = '',
    this.password = '',
    this.isRememberMe = false,
    this.userType = const Catalog(id: "admin", value: "Admin"),
    status,
  }) : status = (status != null) ? status : InitialStatus();

  LoginState copyWith({
    String? persistUsername,
    String? username,
    String? password,
    Catalog? userType,
    bool? isRememberMe,
    FormStatus? status,
  }) {
    return LoginState(
      persistUsername: persistUsername ?? this.persistUsername,
      username: username ?? this.username,
      password: password ?? this.password,
      userType: userType ?? this.userType,
      isRememberMe: isRememberMe ?? this.isRememberMe,
      status: status ?? InitialStatus(),
    );
  }

  _makeData() {
    return LoginInfo(email: username, password: password, role: userType.id);
  }

  @override
  List<Object?> get props => [
        persistUsername,
        username,
        password,
        status,
        userType,
        isRememberMe,
      ];

  final List<Catalog> userTypeList = const [
    Catalog(id: "admin", value: "Admin"),
    Catalog(id: "user", value: "User"),
    Catalog(id: "operator", value: "Operator"),
  ];
}
