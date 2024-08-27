part of 'new_member_bloc.dart';

class NewMemberState extends Equatable {
  final String emailAddress;
  final Catalog? nationality;
  final UserPersonalInfo? userPersonalInfo;

  const NewMemberState({
    this.emailAddress = "",
    this.nationality,
    this.userPersonalInfo,
  });

  // UserRegistrationInfo makeRegistrationInfo(UserContactInfo userContactInfo) => _makeRegistrationInfo(userContactInfo);

  NewMemberState copyWith({
    String? emailAddress,
    Catalog? nationality,
    UserPersonalInfo? userPersonalInfo,
  }) {
    return NewMemberState(
      emailAddress: emailAddress ?? this.emailAddress,
      userPersonalInfo: userPersonalInfo ?? this.userPersonalInfo,
      nationality: nationality ?? this.nationality,
    );
  }

  // UserRegistrationInfo _makeRegistrationInfo(UserContactInfo userContactInfo) {
  //   final encryptedUsername = userName.encrypted(key: AppConfig.shared.appKey);
  //   final encryptedPassword = pin.encrypted(key: AppConfig.shared.appKey);

  //   final loginInfo = LoginInfo(
  //     userLoginCredential: UserLoginCredential(
  //       username: encryptedUsername,
  //       password: encryptedPassword,
  //     ),
  //     loginType: LoginType.phoneNumber,
  //   );

  //   final finaluUerPersonalInfo = UserPersonalInfo(
  //     nameEnglish: userPersonalInfo?.nameEnglish,
  //     nameAlternative: userPersonalInfo?.nameAlternative,
  //     fullName: userPersonalInfo?.fullName,
  //     maritalStatus: userPersonalInfo?.maritalStatus,
  //     dateOfBirth: userPersonalInfo?.dateOfBirth,
  //     gender: userPersonalInfo?.gender,
  //     occupation: userPersonalInfo?.occupation,
  //     occupationAlternative: userPersonalInfo?.occupationAlternative,
  //     monthlyIncome: userPersonalInfo?.monthlyIncome,
  //     nationality: nationality,
  //     residentialAddress: userPersonalInfo?.residentialAddress,
  //   );

  //   return UserRegistrationInfo(
  //     autoLogin: false,
  //     processID: registerProcessID,
  //     country: const Catalog(id: "THA", value: "Thailand"),
  //     language: "en",
  //     loginInfo: loginInfo,
  //     customerInviteCode: referralCode,
  //     userInfo: User(
  //       personalInfo: finaluUerPersonalInfo,
  //       userContactInfo: userContactInfo,
  //     ),
  //   );
  // }

  @override
  List<Object?> get props => [emailAddress, nationality, userPersonalInfo];
}
