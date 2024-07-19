part of 'verify_user_id_bloc.dart';

class VerifyUserIdState extends Equatable {
  final String userId;
  final String processID;
  final bool isEmail;
  final FormStatus status;

  RegExp get userNameRegex => isEmail ? AppRegex.email : AppRegex.mobileNumber;
  String get invalidUsernameLocalize => isEmail ? LocaleKeys.emailIdErrorMessage : LocaleKeys.phoneNumberErrorMessage;

  String? get loginIdValidation => (userId == "")
      ? LocaleKeys.emptyErrorMessage.value
      : (userNameRegex.hasMatch(userId))
          ? null
          : invalidUsernameLocalize.value;

  VerifyUserIdState({
    this.userId = '',
    this.processID = '',
    this.isEmail = true,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  VerifyUserIdState copyWith({
    String? userId,
    String? processID,
    bool? isEmail,
    FormStatus? status,
  }) {
    return VerifyUserIdState(
      userId: userId ?? this.userId,
      processID: processID ?? this.processID,
      isEmail: isEmail ?? this.isEmail,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [userId, isEmail, processID, status];
}
