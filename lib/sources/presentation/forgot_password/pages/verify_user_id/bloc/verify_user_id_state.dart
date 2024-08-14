part of 'verify_user_id_bloc.dart';

class VerifyUserIdState extends Equatable {
  final String email;
  final FormStatus status;

  String? get loginIdValidation => (email == "")
      ? LocaleKeys.emptyErrorMessage.value
      : (AppRegex.email.hasMatch(email))
          ? null
          : LocaleKeys.emailIdErrorMessage.value;

  VerifyUserIdState({this.email = "", status}) : status = (status != null) ? status : InitialStatus();

  VerifyUserIdState copyWith({String? email, FormStatus? status}) {
    return VerifyUserIdState(
      email: email ?? this.email,
      status: status ?? InitialStatus()
    );
  }

  @override
  List<Object?> get props => [email, status];
}
