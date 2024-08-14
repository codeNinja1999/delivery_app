part of 'register_form_bloc.dart';

class RegisterFormEvent {}

class FullNameChanged extends RegisterFormEvent {
  FullNameChanged(this.fullName);
  final String fullName;
}

class MobileChanged extends RegisterFormEvent {
  MobileChanged(this.mobileNumber);
  final String mobileNumber;
}

class PasswordChanged extends RegisterFormEvent {
  PasswordChanged(this.password);
  final String password;
}

class ConfirmPasswordChanged extends RegisterFormEvent {
  ConfirmPasswordChanged(this.confirmPassword);
  final String confirmPassword;
}

class RegisterUser extends RegisterFormEvent {
  final String username;
  final String processId;

  RegisterUser({required this.username, required this.processId});
}
