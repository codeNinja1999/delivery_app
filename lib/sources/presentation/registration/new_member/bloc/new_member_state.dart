part of 'new_member_bloc.dart';

class NewMemberState extends Equatable {
  final String userName;
  final String pin;
  final String referralCode;
  final String email;
  final String verificationProcessID;
  final String registerProcessID;
  final Catalog? nationality;
  final bool isEmail;
  final UserPersonalInfo? userPersonalInfo;

  const NewMemberState({
    this.userName = "",
    this.pin = "",
    this.referralCode = "",
    this.email = "",
    this.verificationProcessID = "",
    this.registerProcessID = "",
    this.nationality,
    this.isEmail = true,
    this.userPersonalInfo,
  });

  UserRegistrationInfo makeRegistrationInfo(UserContactInfo userContactInfo) => _makeRegistrationInfo(userContactInfo);

  NewMemberState copyWith({
    String? userName,
    String? pin,
    String? referralCode,
    String? email,
    String? verificationProcessID,
    String? registerProcessID,
    Catalog? nationality,
    bool? isEmail,
    UserPersonalInfo? userPersonalInfo,
  }) {
    return NewMemberState(
      userName: userName ?? this.userName,
      pin: pin ?? this.pin,
      referralCode: referralCode ?? this.referralCode,
      email: email ?? this.email,
      isEmail: isEmail ?? this.isEmail,
      verificationProcessID: verificationProcessID ?? this.verificationProcessID,
      registerProcessID: registerProcessID ?? this.registerProcessID,
      userPersonalInfo: userPersonalInfo ?? this.userPersonalInfo,
      nationality: nationality ?? this.nationality,
    );
  }

  UserRegistrationInfo _makeRegistrationInfo(UserContactInfo userContactInfo) {
    final encryptedUsername = userName.encrypted(key: AppConfig.shared.appKey);
    final encryptedPassword = pin.encrypted(key: AppConfig.shared.appKey);

    final loginInfo = LoginInfo(
      userLoginCredential: UserLoginCredential(
        username: encryptedUsername,
        password: encryptedPassword,
      ),
      loginType: LoginType.phoneNumber,
    );

    final finaluUerPersonalInfo = UserPersonalInfo(
      nameEnglish: userPersonalInfo?.nameEnglish,
      nameAlternative: userPersonalInfo?.nameAlternative,
      fullName: userPersonalInfo?.fullName,
      maritalStatus: userPersonalInfo?.maritalStatus,
      dateOfBirth: userPersonalInfo?.dateOfBirth,
      gender: userPersonalInfo?.gender,
      occupation: userPersonalInfo?.occupation,
      occupationAlternative: userPersonalInfo?.occupationAlternative,
      monthlyIncome: userPersonalInfo?.monthlyIncome,
      nationality: nationality,
      residentialAddress: userPersonalInfo?.residentialAddress,
    );

    return UserRegistrationInfo(
      autoLogin: false,
      processID: registerProcessID,
      country: const Catalog(id: "THA", value: "Thailand"),
      language: "en",
      loginInfo: loginInfo,
      customerInviteCode: referralCode,
      userInfo: User(
        personalInfo: finaluUerPersonalInfo,
        userContactInfo: userContactInfo,
      ),
    );
  }

  @override
  List<Object?> get props => [
        userName,
        pin,
        email,
        isEmail,
        verificationProcessID,
        registerProcessID,
        nationality,
        userPersonalInfo,
      ];
}
