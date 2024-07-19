part of 'register_form_bloc.dart';

class RegisterFormState extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final String mobileNumber;
  final bool isEightCharacterValid;
  final bool isUpperCaseValid;
  final bool isNumericalValueValid;
  final bool isEmail;
  final FormStatus status;

  String? get fullNameValidation {
    List<String> nameParts = fullName.trim().split(" ");
    if (fullName.isNotEmpty && nameParts.length >= 2) {
      return null;
    } else {
      return LocaleKeys.fullNameErrorMessage.value;
    }
  }

  String? get phoneNumberValidation =>
      (AppRegex.mobileNumber.hasMatch(mobileNumber)) ? null : LocaleKeys.phoneNumberErrorMessage.value;

  String? get passwordValidation => (AppRegex.eightDigit.hasMatch(password) &&
          AppRegex.oneLetterCapital.hasMatch(password) &&
          AppRegex.spacialAndNumeric.hasMatch(password))
      ? null
      : LocaleKeys.passwordErrorMessage.value;

  UserRegistrationInfo makeRegistrationInfo(String username, String processId) => _makeRegistrationInfo(username, processId);

  RegisterFormState({
    this.fullName = "",
    this.email = "",
    this.password = "",
    this.mobileNumber = "",
    this.isEightCharacterValid = false,
    this.isUpperCaseValid = false,
    this.isNumericalValueValid = false,
    this.isEmail = true,
    FormStatus? status,
  }) : status = status ?? InitialStatus();

  RegisterFormState copyWith({
    String? fullName,
    String? password,
    String? email,
    String? mobileNumber,
    bool? isEightCharacterValid,
    bool? isUpperCaseValid,
    bool? isNumericalValueValid,
    bool? isEmail,
    FormStatus? status,
  }) {
    return RegisterFormState(
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      fullName: fullName ?? this.fullName,
      password: password ?? this.password,
      isEightCharacterValid: isEightCharacterValid ?? this.isEightCharacterValid,
      isUpperCaseValid: isUpperCaseValid ?? this.isUpperCaseValid,
      isNumericalValueValid: isNumericalValueValid ?? this.isNumericalValueValid,
      isEmail: isEmail ?? this.isEmail,
      status: status ?? this.status,
    );
  }

  UserRegistrationInfo _makeRegistrationInfo(String username, String processId) {
    final encryptedUsername = username.encrypted(key: AppConfig.shared.appKey);
    final encryptedPassword = password.encrypted(key: AppConfig.shared.appKey);
    final encryptedEmail = (email != "") ? email.encrypted(key: AppConfig.shared.appKey) : "";
    final encryptedNumber = (mobileNumber != "") ? mobileNumber.encrypted(key: AppConfig.shared.appKey) : "";

    final loginInfo = LoginInfo(
      userLoginCredential: UserLoginCredential(
        username: encryptedUsername,
        password: encryptedPassword,
      ),
      loginType: LoginType.phoneNumber,
    );

    final nameParts = fullName.trim().split(' ');
    final firstName = nameParts.first;
    final lastName = nameParts.last;
    final middleName = nameParts.length > 2 ? nameParts.sublist(1, nameParts.length - 1).join(' ') : '';

    final userPersonalInfo = UserPersonalInfo(
      nameEnglish: EnglishName(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
      ),
      nameAlternative: "",
      fullName: fullName,
    );

    final contactInfo = UserContactInfo(
      residentialContactInfo: ContactInfo(
        emailAddress: isEmail ? encryptedUsername : encryptedEmail,
        mobileNumber: isEmail ? encryptedNumber : encryptedUsername,
      ),
    );

    return UserRegistrationInfo(
      autoLogin: false,
      processID: processId,
      country: const Catalog(id: AppConstants.senderCountryCode, value: AppConstants.senderCountry),
      language: "en",
      loginInfo: loginInfo,
      userInfo: User(personalInfo: userPersonalInfo, userContactInfo: contactInfo),
    );
  }

  @override
  List<Object?> get props => [
        fullName,
        email,
        mobileNumber,
        password,
        isEightCharacterValid,
        isUpperCaseValid,
        isNumericalValueValid,
        isEmail,
        status,
      ];
}
