part of 'login_bloc.dart';

abstract class LoginEvent {}

class AuthenticateUser extends LoginEvent {}

class RememberMe extends LoginEvent {}

class CheckUserIfPersist extends LoginEvent {}

class UsernameNumberChanged extends LoginEvent {
  final String username;
  UsernameNumberChanged(this.username);
}

class UserTypeSelected extends LoginEvent {
  final Catalog userType;
  UserTypeSelected(this.userType);
}

class PasswordChanged extends LoginEvent {
  final String password;
  PasswordChanged(this.password);
}
