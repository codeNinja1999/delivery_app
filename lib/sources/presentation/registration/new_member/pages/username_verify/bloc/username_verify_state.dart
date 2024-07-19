part of 'username_verify_bloc.dart';

class UsernameVerifyState extends Equatable {
  final String userId;
  final String processID;
  final bool isEmail;
  final FormStatus status;

  RegExp get userNameRegex => isEmail ? AppRegex.email : AppRegex.mobileNumber;
  String get invalidUsernameLocalize => isEmail ? LocaleKeys.emailIdErrorMessage : LocaleKeys.phoneNumberErrorMessage;

  String? get usernameValidation => userId == ""
      ? LocaleKeys.emptyErrorMessage.value
      : (userNameRegex.hasMatch(userId))
          ? null
          : invalidUsernameLocalize.value;

  UsernameVerifyState({
    this.userId = "",
    this.processID = "",
    this.isEmail = true,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  UsernameVerifyState copyWith({
    String? userId,
    String? processID,
    bool? isEmail,
    FormStatus? status,
  }) {
    return UsernameVerifyState(
      userId: userId ?? this.userId,
      processID: processID ?? this.processID,
      isEmail: isEmail ?? this.isEmail,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [
        userId,
        processID,
        isEmail,
        status,
      ];
}
