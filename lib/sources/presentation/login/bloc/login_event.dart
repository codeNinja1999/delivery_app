part of 'login_bloc.dart';

abstract class LoginEvent {}

class AuthenticateUser extends LoginEvent {}

class UsernameNumberChanged extends LoginEvent {
  final String username;

  UsernameNumberChanged(this.username);
}

class CheckUserIfPersist extends LoginEvent {
  CheckUserIfPersist();
}

class PasswordChanged extends LoginEvent {
  final String password;

  PasswordChanged(this.password);
}

class RememberMe extends LoginEvent {}
