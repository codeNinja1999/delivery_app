import 'package:equatable/equatable.dart';

class LoginViewModel extends Equatable {
  final String username;
  final String password;
  final String? deviceVerificationProcessId;
  final bool shouldRemember;

  const LoginViewModel({
    required this.username,
    required this.password,
    this.deviceVerificationProcessId,
    required this.shouldRemember,
  });

  @override
  List<Object?> get props =>
      [username, password, deviceVerificationProcessId, shouldRemember];

  LoginViewModel copyWith({required String deviceVerificationProcessId}) {
    return LoginViewModel(
      username: username,
      password: password,
      deviceVerificationProcessId: deviceVerificationProcessId,
      shouldRemember: shouldRemember,
    );
  }
}
