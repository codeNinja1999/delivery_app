import 'package:fresh_fold_delivery/repository/data/user/models/registration/user_registration_request_model.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/registration/user_registration_info.dart';

extension UserRegistraionRequestDataMapping on UserRegistrationInfo {
  UserRegistrationRequestModel toRequestData() {
    final residentialAddressInfo = AddressInfo(
      masterCode: "",
      addressState: userInfo.userContactInfo.residentialContactInfo.state?.id ?? "",
      addressZipcode: userInfo.userContactInfo.residentialContactInfo.postalCode ?? "",
      addressCity: userInfo.userContactInfo.residentialContactInfo.city?.id ?? "",
      addressStreet: userInfo.userContactInfo.residentialContactInfo.streetAddress ?? "",
      addressInput: userInfo.userContactInfo.residentialContactInfo.streetNumber,
      addressInput1: userInfo.userContactInfo.residentialContactInfo.streetName,
      addressStateJpn: "",
    );
    final workAddressInfo = AddressInfo(
        addressZipcode: userInfo.userContactInfo.wordkContactInfo?.postalCode ?? "",
        addressState: userInfo.userContactInfo.wordkContactInfo?.state?.id ?? "",
        addressCity: userInfo.userContactInfo.wordkContactInfo?.city?.id ?? "",
        addressStreet: userInfo.userContactInfo.wordkContactInfo?.streetAddress ?? "");

    final identificationInfo = IdentificationInfo(
        idTypeCode: userInfo.identificationInfo?.idType?.id ?? "",
        idTypeValue: userInfo.identificationInfo?.idType?.value ?? "",
        idNumber: userInfo.identificationInfo?.idNumber ?? "",
        issueDate: userInfo.identificationInfo?.issuedDate ?? "",
        expireDate: userInfo.identificationInfo?.expiryDate ?? "",
        isIdExpire: false,
        issueCountryCode: userInfo.identificationInfo?.issuedCountry?.id,
        issueCountryState: "",
        senderType: "");

    final nameEnglish = Name(
      firstName: userInfo.personalInfo.nameEnglish?.firstName ?? "",
      middleName: userInfo.personalInfo.nameEnglish?.middleName ?? "",
      lastName: userInfo.personalInfo.nameEnglish?.lastName ?? "",
      lastName2: "",
    );

    final alternateName = Name(firstName: "", middleName: "", lastName: "", lastName2: "");

    final memberInfo = RegisterMemberInfo(
      isPostalCodeSpecified: false,
      campaignCode: campaignCode ?? "",
      senderCountry: country?.id ?? "",
      nameEnglish: nameEnglish,
      addressInfo: residentialAddressInfo,
      addressWorkInfo: workAddressInfo,
      identificationInfo: identificationInfo,
      nationality: userInfo.personalInfo.nationality?.id ?? "",
      gender: userInfo.personalInfo.gender?.id ?? "",
      birthPlace: userInfo.personalInfo.birtPlace ?? "",
      birthday: userInfo.personalInfo.dateOfBirth ?? "",
      mobilePhoneNumber: userInfo.userContactInfo.residentialContactInfo.mobileNumber ?? "",
      emailAddress1: userInfo.userContactInfo.residentialContactInfo.emailAddress ?? "",
      userName: loginInfo.userLoginCredential?.username ?? "",
      password: loginInfo.userLoginCredential?.password ?? "",
      homePhoneNumber: "",
      occupationCode: userInfo.personalInfo.occupation?.id,
      occupationOthers: userInfo.personalInfo.occupationAlternative,
      sourceOfFundsCode: userInfo.personalInfo.sourceOfIncome?.id,
      sourceOfFundsOthers: "",
      emailDisplayLanguage: language,
      referrerId: referralCode ?? "",
      customerInviteCode: customerInviteCode ?? "",
      nameAlternate: alternateName,
      tosAgreed: "",
      maritalStatus: userInfo.personalInfo.maritalStatus?.id,
      monthlyIncome: userInfo.personalInfo.monthlyIncome?.id,
      residentialAddress: userInfo.personalInfo.residentialAddress ?? "",
    );
    final level1KycImage = CustomerProfileImage(
      imageSelfie: levelOneKyc?.imageSelfie,
      imageSignature: levelOneKyc?.imageSignature,
      imageBirthCertificate: levelOneKyc?.imageBirthCertificate,
      imageParentConsent: levelOneKyc?.imageParentConsent,
      imageParentGovId: levelOneKyc?.imageParentGovId,
    );

    final requestData = UserRegistrationRequestModel(
      processId: processID,
      autoLoginAfterRegistration: autoLogin,
      memberInfo: memberInfo,
      customerProfileImage: level1KycImage,
    );
    return requestData;
  }
}
