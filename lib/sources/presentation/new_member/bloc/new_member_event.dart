part of 'new_member_bloc.dart';

abstract class NewMemberEvent {}

class VerificationDetailCollected extends NewMemberEvent {
  final String emailAddress;
  VerificationDetailCollected({required this.emailAddress});
}

class SaveNationality extends NewMemberEvent {
  final Catalog? nationality;
  SaveNationality(this.nationality);
}

class SaveUserPersonalInfo extends NewMemberEvent {
  final UserPersonalInfo userPersonalInfo;
  SaveUserPersonalInfo({required this.userPersonalInfo});
}
