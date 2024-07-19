part of 'user_agreement_bloc.dart';

class UserAgreementEvent {}

class LoadPdf extends UserAgreementEvent {}

class ProgressChanged extends UserAgreementEvent {
  ProgressChanged(this.progressValue);
  final int progressValue;
}