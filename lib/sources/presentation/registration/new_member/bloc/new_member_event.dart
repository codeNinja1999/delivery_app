part of 'new_member_bloc.dart';

abstract class NewMemberEvent {}

class VerificationDetailCollected extends NewMemberEvent {
  final String? userName;
  final String processId;
  final bool isEmail;
  VerificationDetailCollected(
      {required this.userName, required this.processId, required this.isEmail});
}

class SaveRegisterProcessID extends NewMemberEvent {
  final String processId;
  SaveRegisterProcessID(this.processId);
}

class SaveNationality extends NewMemberEvent {
  final Catalog? nationality;
  SaveNationality(this.nationality);
}

class SaveReferralCode extends NewMemberEvent {
  final String referralCode;
  SaveReferralCode(this.referralCode);
}

class SetUserPin extends NewMemberEvent {
  final String pin;
  SetUserPin(this.pin);
}

class SaveUserPersonalInfo extends NewMemberEvent {
  final UserPersonalInfo userPersonalInfo;
  final String? email;
  SaveUserPersonalInfo({required this.userPersonalInfo, this.email});
}
