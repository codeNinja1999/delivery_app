part of 'verify_email_bloc.dart';

class VerifyEmailState extends Equatable {
  final String emailAddress;
  final FormStatus status;

  String? get emailValidation => emailAddress == ""
      ? LocaleKeys.emptyErrorMessage.value
      : (AppRegex.email.hasMatch(emailAddress))
          ? null
          : LocaleKeys.emailIdErrorMessage.value;

  VerifyEmailState({this.emailAddress = "", status}) : status = (status != null) ? status : InitialStatus();

  VerifyEmailState copyWith({String? emailAddress, FormStatus? status}) {
    return VerifyEmailState(
      emailAddress: emailAddress ?? this.emailAddress,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [emailAddress, status];
}
