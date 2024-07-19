part of 'verify_number_bloc.dart';

class VerifyNumberState extends Equatable {
  final String userId;
  final String processID;
  final FormStatus status;

  String? get usernameValidation => userId == ""
      ? LocaleKeys.emptyErrorMessage.value
      : (AppRegex.mobileNumber.hasMatch(userId))
          ? null
          : LocaleKeys.phoneNumberErrorMessage.value;

  VerifyNumberState({
    this.userId = "",
    this.processID = "",
    status,
  }) : status = (status != null) ? status : InitialStatus();

  VerifyNumberState copyWith({
    String? userId,
    String? processID,
    bool? isEmail,
    FormStatus? status,
  }) {
    return VerifyNumberState(
      userId: userId ?? this.userId,
      processID: processID ?? this.processID,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [userId, processID, status];
}
