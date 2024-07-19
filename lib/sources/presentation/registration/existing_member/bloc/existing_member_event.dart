part of 'existing_member_bloc.dart';

abstract class ExistingMemberEvent {}

class VerificationDetailCollected extends ExistingMemberEvent {
  final String? userName;
  final String processId;
  VerificationDetailCollected({required this.userName, required this.processId});
}

class SaveProcessID extends ExistingMemberEvent {
  final String processId;
  SaveProcessID(this.processId);
}

class SaveAzureInfo extends ExistingMemberEvent {
  final AzureInfo? azureInfo;
  SaveAzureInfo(this.azureInfo);
}

class SaveSelfieImage extends ExistingMemberEvent {
  final String? selfieImageName;
  SaveSelfieImage(this.selfieImageName);
}

class SaveExistingMemberResult extends ExistingMemberEvent {
  final CheckExistingMemberResult? existingMemberResult;
  SaveExistingMemberResult(this.existingMemberResult);
}

class SetUserPassword extends ExistingMemberEvent {
  final String password;
  SetUserPassword(this.password);
}

class SaveUserPersonalInfo extends ExistingMemberEvent {
  final UserPersonalInfo userPersonalInfo;
  final String? email;
  SaveUserPersonalInfo({required this.userPersonalInfo, this.email});
}

class GetLocalImage extends ExistingMemberEvent {
  final ScanType scanFor;
  final ScanBy scanBy;
  GetLocalImage(this.scanFor, this.scanBy);
}
