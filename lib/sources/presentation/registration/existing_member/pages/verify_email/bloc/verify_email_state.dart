part of 'verify_email_bloc.dart';

class VerifyEmailState extends Equatable {
  final String emailAddress;
  final String processID;
  final FormStatus status;

  String? get usernameValidation => emailAddress == ""
      ? LocaleKeys.emptyErrorMessage.value
      : (AppRegex.email.hasMatch(emailAddress))
          ? null
          : LocaleKeys.emailIdErrorMessage.value;

  VerifyEmailState({
    this.emailAddress = "",
    this.processID = "",
    status,
  }) : status = (status != null) ? status : InitialStatus();

  VerifyEmailState copyWith({
    String? emailAddress,
    String? processID,
    bool? isEmail,
    FormStatus? status,
  }) {
    return VerifyEmailState(
      emailAddress: emailAddress ?? this.emailAddress,
      processID: processID ?? this.processID,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [emailAddress, processID, status];
}
