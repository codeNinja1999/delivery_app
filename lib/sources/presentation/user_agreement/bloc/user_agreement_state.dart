part of 'user_agreement_bloc.dart';

class UserAgreementState extends Equatable {
  final File? pdf;
  final int progressValue;
  final FormStatus status;

  UserAgreementState({this.pdf, this.progressValue=0, status}) : status = (status != null) ? status : InitialStatus();

  UserAgreementState copyWith({
    File? pdf,
    int? progressValue,
    FormStatus? status,
  }) {
    return UserAgreementState(
      pdf: pdf ?? this.pdf,
      progressValue: progressValue ?? this.progressValue,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [pdf,progressValue, status];
}
