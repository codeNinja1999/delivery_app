class UserRegistrationRequestModel {
  UserRegistrationRequestModel({
    this.processId,
    this.autoLoginAfterRegistration,
    this.memberInfo,
    this.customerProfileImage,
  });

  final String? processId;
  final bool? autoLoginAfterRegistration;
  final RegisterMemberInfo? memberInfo;
  final CustomerProfileImage? customerProfileImage;

  Map<String, dynamic> toJson() => {
        "process_id": processId,
        "auto_login_after_registration": autoLoginAfterRegistration,
        "member_info": memberInfo?.toJson(),
        "customer_profile_image": customerProfileImage?.toJson(),
      };
}

class RegisterMemberInfo {
  RegisterMemberInfo(
      {this.isPostalCodeSpecified,
      this.campaignCode,
      this.senderCountry,
      this.addressInfo,
      this.addressWorkInfo,
      this.identificationInfo,
      this.tosAgreed,
      this.customerInviteCode,
      this.referrerId,
      this.nationality,
      this.gender,
      this.birthday,
      this.mobilePhoneNumber,
      this.homePhoneNumber,
      this.occupationCode,
      this.occupationOthers,
      this.sourceOfFundsCode,
      this.sourceOfFundsOthers,
      this.emailAddress1,
      this.userName,
      this.password,
      this.emailDisplayLanguage,
      this.nameEnglish,
      this.nameAlternate,
      this.maritalStatus,
      this.monthlyIncome,
      this.residentialAddress,
      this.birthPlace});

  final bool? isPostalCodeSpecified;
  final String? campaignCode;
  final String? senderCountry;
  final AddressInfo? addressInfo;
  final AddressInfo? addressWorkInfo;
  final IdentificationInfo? identificationInfo;
  final String? tosAgreed;
  final String? customerInviteCode;
  final String? referrerId;
  final String? nationality;
  final String? gender;
  final String? birthday;
  final String? mobilePhoneNumber;
  final String? homePhoneNumber;
  final String? occupationCode;
  final String? occupationOthers;
  final String? sourceOfFundsCode;
  final String? sourceOfFundsOthers;
  final String? emailAddress1;
  final String? userName;
  final String? password;
  final String? emailDisplayLanguage;
  final Name? nameEnglish;
  final Name? nameAlternate;
  final String? maritalStatus;
  final String? monthlyIncome;
  final String? residentialAddress;
  final String? birthPlace;

  Map<String, dynamic> toJson() => {
        "is_postal_code_specified": isPostalCodeSpecified,
        "campaign_code": campaignCode,
        "sender_country": senderCountry,
        "address_info": addressInfo?.toJson(),
        "address_work_info": addressWorkInfo?.toJson(),
        "identification_info": identificationInfo?.toJson(),
        "tos_agreed": tosAgreed,
        "customer_invite_code": customerInviteCode,
        "referrer_id": referrerId,
        "nationality": nationality,
        "gender": gender,
        "birthday": birthday,
        "mobile_phone_number": mobilePhoneNumber,
        "home_phone_number": homePhoneNumber,
        "occupation_code": occupationCode,
        "occupation_others": occupationOthers,
        "source_of_funds_code": sourceOfFundsCode,
        "source_of_funds_others": sourceOfFundsOthers,
        "email_address1": emailAddress1,
        "user_name": userName,
        "password": password,
        "email_display_language": emailDisplayLanguage,
        "name_english": nameEnglish?.toJson(),
        "name_alternate": nameAlternate?.toJson(),
        "marital_status": maritalStatus,
        "monthly_income": monthlyIncome,
        "residential_address": residentialAddress,
        "birth_place": birthPlace,
      };
}

class AddressInfo {
  AddressInfo({
    this.masterCode,
    this.addressZipcode,
    this.addressStreet,
    this.addressCity,
    this.addressStateJpn,
    this.addressState,
    this.addressInput,
    this.addressInput1,
  });

  final String? masterCode;
  final String? addressZipcode;
  final String? addressStreet;
  final String? addressCity;
  final String? addressStateJpn;
  final String? addressState;
  final String? addressInput;
  final String? addressInput1;

  Map<String, dynamic> toJson() => {
        "master_code": masterCode,
        "address_zipcode": addressZipcode,
        "address_street": addressStreet,
        "address_city": addressCity,
        "address_state_jpn": addressStateJpn,
        "address_state": addressState,
        "address_input": addressInput,
        "address_input1": addressInput1,
      };
}

class IdentificationInfo {
  IdentificationInfo({
    this.idTypeCode,
    this.idTypeValue,
    this.idNumber,
    this.issueDate,
    this.expireDate,
    this.isIdExpire,
    this.issueCountryCode,
    this.issueCountryState,
    this.senderType,
  });

  final String? idTypeCode;
  final String? idTypeValue;
  final String? idNumber;
  final String? issueDate;
  final String? expireDate;
  final bool? isIdExpire;
  final String? issueCountryCode;
  final String? issueCountryState;
  final String? senderType;

  Map<String, dynamic> toJson() => {
        "id_type_code": idTypeCode,
        "id_type_value": idTypeValue,
        "id_number": idNumber,
        "issue_date": issueDate,
        "expire_date": expireDate,
        "is_id_expire": isIdExpire,
        "issue_country_code": issueCountryCode,
        "issue_country_state": issueCountryState,
        "sender_type": senderType,
      };
}

class Name {
  Name({
    this.lastName,
    this.firstName,
    this.middleName,
    this.lastName2,
  });

  final String? lastName;
  final String? firstName;
  final String? middleName;
  final String? lastName2;

  Map<String, dynamic> toJson() => {
        "last_name": lastName,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name2": lastName2,
      };
}

class CustomerProfileImage {
  CustomerProfileImage({
    this.imageSelfie,
    this.imageSignature,
    this.imageBirthCertificate,
    this.imageParentConsent,
    this.imageParentGovId,
  });

  String? imageSelfie;
  String? imageSignature;
  String? imageBirthCertificate;
  String? imageParentConsent;
  String? imageParentGovId;

  factory CustomerProfileImage.fromJson(Map<String, dynamic> json) => CustomerProfileImage(
        imageSelfie: json["image_selfie"],
        imageSignature: json["image_signature"],
        imageBirthCertificate: json["image_birth_certificate"],
        imageParentConsent: json["image_parent_consent"],
        imageParentGovId: json["image_parent_gov_id"],
      );

  Map<String, dynamic> toJson() => {
        "image_selfie": imageSelfie,
        "image_signature": imageSignature,
        "image_birth_certificate": imageBirthCertificate,
        "image_parent_consent": imageParentConsent,
        "image_parent_gov_id": imageParentGovId,
      };
}
