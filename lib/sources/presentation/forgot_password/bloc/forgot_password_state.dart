part of 'forgot_password_bloc.dart';

class ForgotPasswordState extends Equatable {
  final String emailAddress;

  const ForgotPasswordState({this.emailAddress = ""});

  ForgotPasswordState copyWith({
    String? emailAddress,
  }) {
    return ForgotPasswordState(
      emailAddress: emailAddress ?? this.emailAddress,
    );
  }

  @override
  List<Object?> get props => [emailAddress];
}
