part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  final String email;
  final String otp;

  const ForgotPasswordState({this.email = "", this.otp = ""});

  ForgotPasswordState copyWith({
    String? email,
    String? otp,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      otp: otp ?? this.otp,
    );
  }

  @override
  List<Object?> get props => [email, otp];
}
