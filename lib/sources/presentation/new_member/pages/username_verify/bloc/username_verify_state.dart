part of 'username_verify_bloc.dart';

class UsernameVerifyState extends Equatable {
  final String emailAddress;
  final FormStatus status;

  String? get emailValidation => emailAddress == ""
      ? LocaleKeys.emptyErrorMessage.value
      : (AppRegex.email.hasMatch(emailAddress))
          ? null
          : LocaleKeys.emailIdErrorMessage.value;

  UsernameVerifyState({this.emailAddress = "", status}) : status = (status != null) ? status : InitialStatus();

  UsernameVerifyState copyWith({String? emailAddress, FormStatus? status}) {
    return UsernameVerifyState(
      emailAddress: emailAddress ?? this.emailAddress,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [emailAddress, status];
}
