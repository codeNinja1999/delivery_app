part of 'register_form_bloc.dart';

class RegisterFormEvent {}

class FullNameChanged extends RegisterFormEvent {
  FullNameChanged(this.fullName);
  final String fullName;
}

class EmailChanged extends RegisterFormEvent {
  EmailChanged(this.email);
  final String email;
}

class MobileChanged extends RegisterFormEvent {
  MobileChanged(this.mobileNumber);
  final String mobileNumber;
}

class PasswordChanged extends RegisterFormEvent {
  PasswordChanged(this.password);
  final String password;
}

class RegisterUser extends RegisterFormEvent {
  final String username;
  final String processId;

  RegisterUser({required this.username, required this.processId});
}

class UpdateVerification extends RegisterFormEvent {
  final bool isEmail;
  UpdateVerification(this.isEmail);
}
