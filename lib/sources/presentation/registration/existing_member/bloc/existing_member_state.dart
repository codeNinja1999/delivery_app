part of 'existing_member_bloc.dart';

class ExistingMemberState extends Equatable {
  final String userName;
  final String password;
  final String email;
  final String verificationProcessID;
  final String processID;
  final File? selfieImage;
  final String? selfieImageName;
  final AzureInfo? azureInfo;
  final CheckExistingMemberResult? existingMemberResult;
  final UserPersonalInfo? userPersonalInfo;

  const ExistingMemberState({
    this.userName = "",
    this.password = "",
    this.email = "",
    this.verificationProcessID = "",
    this.processID = "",
    this.selfieImage,
    this.selfieImageName,
    this.azureInfo,
    this.existingMemberResult,
    this.userPersonalInfo,
  });

  ExistingMemberState copyWith({
    String? userName,
    String? password,
    String? email,
    String? verificationProcessID,
    String? processID,
    Catalog? nationality,
    File? selfieImage,
    String? selfieImageName,
    AzureInfo? azureInfo,
    CheckExistingMemberResult? existingMemberResult,
    UserPersonalInfo? userPersonalInfo,
  }) {
    return ExistingMemberState(
      userName: userName ?? this.userName,
      password: password ?? this.password,
      email: email ?? this.email,
      verificationProcessID: verificationProcessID ?? this.verificationProcessID,
      processID: processID ?? this.processID,
      userPersonalInfo: userPersonalInfo ?? this.userPersonalInfo,
      selfieImage: selfieImage ?? this.selfieImage,
      selfieImageName: selfieImageName ?? this.selfieImageName,
      azureInfo: azureInfo ?? this.azureInfo,
      existingMemberResult: existingMemberResult ?? this.existingMemberResult,
    );
  }

  @override
  List<Object?> get props => [
        userName,
        password,
        email,
        selfieImage,
        verificationProcessID,
        processID,
        selfieImageName,
        azureInfo,
        existingMemberResult,
        userPersonalInfo,
      ];
}
