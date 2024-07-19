class GetuserinfoResponseModel {
  GetuserinfoResponseModel({
    this.memberInfo,
  });

  final MemberInfo? memberInfo;

  factory GetuserinfoResponseModel.fromJson(Map<String, dynamic> json) =>
      GetuserinfoResponseModel(memberInfo: MemberInfo.fromJson(json["member_info"]));
}

class MemberInfo {
  MemberInfo({
    this.customerId,
    this.emailAddress1Authenticated,
    this.emailAddress2,
    this.emailAddress2Authenticated,
    this.mobileNumberAuthenticated,
    this.campaignCode,
    this.isPostalCodeSpecified,
    this.corporateFlag,
    this.corporateInfo,
    this.lastLoginTs,
    this.customerFundBankAcc,
    this.identificationInfo,
    this.walletBalance,
    this.walletPending,
    this.fgTransactionPassword,
    this.rewardPoints,
    this.kycStatus,
    this.documentsUploaded,
    this.lastUpdateTs,
    this.customerProfileDocument,
    this.nationality,
    this.nationalityName,
    this.gender,
    this.birthday,
    this.mobilePhoneNumber,
    this.homePhoneNumber,
    this.occupationCode,
    this.occupationValue,
    this.occupationOthers,
    this.emailAddress1,
    this.userName,
    this.emailDisplayLanguage,
    this.addressInfo,
    this.nameEnglish,
    this.nameAlternate,
    this.birthPlace,
  });

  final String? customerId;
  final bool? emailAddress1Authenticated;
  final String? emailAddress2;
  final bool? emailAddress2Authenticated;
  final bool? mobileNumberAuthenticated;
  final String? campaignCode;
  final bool? isPostalCodeSpecified;
  final bool? corporateFlag;
  final CorporateInfo? corporateInfo;
  final DateTime? lastLoginTs;
  final CustomerFundBankAcc? customerFundBankAcc;
  final IdentificationInfo? identificationInfo;
  final String? walletBalance;
  final String? walletPending;
  final String? fgTransactionPassword;
  final String? rewardPoints;
  final String? kycStatus;
  final String? documentsUploaded;
  final DateTime? lastUpdateTs;
  final CustomerProfileDocument? customerProfileDocument;
  final String? nationality;
  final String? nationalityName;
  final String? gender;
  final String? birthday;
  final String? birthPlace;
  final String? mobilePhoneNumber;
  final String? homePhoneNumber;
  final String? occupationCode;
  final String? occupationValue;
  final String? occupationOthers;
  final String? emailAddress1;
  final String? userName;
  final String? emailDisplayLanguage;
  final AddressInfo? addressInfo;
  final Name? nameEnglish;
  final Name? nameAlternate;

  factory MemberInfo.fromJson(Map<String, dynamic> json) => MemberInfo(
      customerId: json["customer_id"],
      emailAddress1Authenticated: json["email_address1_authenticated"],
      emailAddress2: json["email_address2"],
      emailAddress2Authenticated: json["email_address2_authenticated"],
      mobileNumberAuthenticated: json["mobile_number_authenticated"],
      campaignCode: json["campaign_code"],
      isPostalCodeSpecified: json["is_postal_code_specified"],
      corporateFlag: json["corporate_flag"],
      corporateInfo: CorporateInfo.fromJson(json["corporate_info"]),
      lastLoginTs: DateTime.parse(json["last_login_ts"]),
      customerFundBankAcc: CustomerFundBankAcc.fromJson(json["customer_fund_bank_acc"]),
      identificationInfo: IdentificationInfo.fromJson(json["identification_info"]),
      walletBalance: json["wallet_balance"],
      walletPending: json["wallet_pending"],
      fgTransactionPassword: json["fg_transaction_password"],
      rewardPoints: json["reward_points"],
      kycStatus: json["kyc_status"],
      documentsUploaded: json["documents_uploaded"],
      lastUpdateTs: DateTime.parse(json["last_update_ts"]),
      customerProfileDocument: CustomerProfileDocument.fromJson(json["customer_profile_document"]),
      nationality: json["nationality"],
      nationalityName: json["nationality_name"],
      gender: json["gender"],
      birthday: json["birthday"],
      mobilePhoneNumber: json["mobile_phone_number"],
      homePhoneNumber: json["home_phone_number"],
      occupationCode: json["occupation_code"],
      occupationValue: json["occupation_value"],
      occupationOthers: json["occupation_others"],
      emailAddress1: json["email_address1"],
      userName: json["user_name"],
      emailDisplayLanguage: json["email_display_language"],
      addressInfo: AddressInfo.fromJson(json["address_info"]),
      nameEnglish: Name.fromJson(json["name_english"]),
      nameAlternate: Name.fromJson(json["name_alternate"]),
      birthPlace: json["birth_place"]);
}

class AddressInfo {
  AddressInfo({
    this.zipCode,
    this.masterCode,
    this.addressState,
    this.addressStateJpn,
    this.addressStateJpn2,
    this.addressStreet,
    this.addressCity,
    this.addressInput,
    this.country,
  });

  final String? zipCode;
  final String? masterCode;
  final String? addressState;
  final String? addressStateJpn;
  final String? addressStateJpn2;
  final String? addressStreet;
  final String? addressCity;
  final String? addressInput;
  final String? country;

  factory AddressInfo.fromJson(Map<String, dynamic> json) => AddressInfo(
        zipCode: json["zip_code"],
        masterCode: json["master_code"],
        addressState: json["address_state"],
        addressStateJpn: json["address_state_jpn"],
        addressStateJpn2: json["address_state_jpn2"],
        addressStreet: json["address_street"],
        addressCity: json["address_city"],
        addressInput: json["address_input"],
        country: json["country"],
      );
}

class CorporateInfo {
  CorporateInfo({
    this.corporateName,
    this.telephoneNumber,
    this.zipCode,
    this.prefectureTownRomaji,
    this.prefectureTownKanji,
    this.addressStreet,
    this.addressBuilding,
  });

  final String? corporateName;
  final String? telephoneNumber;
  final String? zipCode;
  final String? prefectureTownRomaji;
  final String? prefectureTownKanji;
  final String? addressStreet;
  final String? addressBuilding;

  factory CorporateInfo.fromJson(Map<String, dynamic> json) => CorporateInfo(
        corporateName: json["corporate_name"],
        telephoneNumber: json["telephone_number"],
        zipCode: json["zip_code"],
        prefectureTownRomaji: json["prefecture_town_romaji"],
        prefectureTownKanji: json["prefecture_town_kanji"],
        addressStreet: json["address_street"],
        addressBuilding: json["address_building"],
      );
}

class CustomerFundBankAcc {
  CustomerFundBankAcc({
    this.bankCode,
    this.bankName,
    this.branchCode,
    this.branchName,
    this.depositTypeCode,
    this.accountNumber,
    this.accountName,
  });

  final String? bankCode;
  final String? bankName;
  final String? branchCode;
  final String? branchName;
  final String? depositTypeCode;
  final String? accountNumber;
  final String? accountName;

  factory CustomerFundBankAcc.fromJson(Map<String, dynamic> json) => CustomerFundBankAcc(
        bankCode: json["bank_code"],
        bankName: json["bank_name"],
        branchCode: json["branch_code"],
        branchName: json["branch_name"],
        depositTypeCode: json["deposit_type_code"],
        accountNumber: json["account_number"],
        accountName: json["account_name"],
      );
}

class CustomerProfileDocument {
  String? customerProfileImage;
  String? customerSelfieImage;
  String? documentFrontImage;
  String? documentBackImage;
  String? additionalFrontImage;
  String? additionalBackImage;

  CustomerProfileDocument({
    this.customerProfileImage,
    this.customerSelfieImage,
    this.documentFrontImage,
    this.documentBackImage,
    this.additionalFrontImage,
    this.additionalBackImage,
  });

  factory CustomerProfileDocument.fromJson(Map<String, dynamic> json) => CustomerProfileDocument(
        customerProfileImage: json["customer_profile_image"],
        customerSelfieImage: json["customer_selfie_image"],
        documentFrontImage: json["document_front_image"],
        documentBackImage: json["document_back_image"],
        additionalFrontImage: json["additional_front_image"],
        additionalBackImage: json["additional_back_image"],
      );
}

class IdentificationInfo {
  IdentificationInfo({
    this.idTypeCode,
    this.idTypeValue,
    this.idNumber,
    this.idTypeOption,
    this.issueDate,
    this.expireDate,
    this.isIdExpire,
    this.issueCountryCode,
    this.issueCountryValue,
    this.issueCountryState,
    this.idIssueJurisdiction,
    this.idIssueJurisdictionOther,
    this.senderType,
    this.customerId,
    this.secondaryIdTypeCode,
    this.secondaryIdTypeValue,
    this.secondaryIdNumber,
    this.secondaryIssueDate,
    this.secondaryExpireDate,
    this.secondaryIsIdExpire,
    this.secondaryIssueCountryCode,
    this.secondaryIssueCountryValue,
    this.nameOnCard,
    this.encryptEmailAddress,
    this.medicareCardType,
    this.medicareRefno,
    this.medicareName,
    this.medicareDateOfExpiry,
  });

  final String? idTypeCode;
  final String? idTypeValue;
  final String? idNumber;
  final String? idTypeOption;
  final String? issueDate;
  final String? expireDate;
  final bool? isIdExpire;
  final String? issueCountryCode;
  final String? issueCountryValue;
  final String? idIssueJurisdiction;
  final String? idIssueJurisdictionOther;
  final String? issueCountryState;
  final String? senderType;
  final String? customerId;
  final String? secondaryIdTypeCode;
  final String? secondaryIdTypeValue;
  final String? secondaryIdNumber;
  final String? secondaryIssueDate;
  final String? secondaryExpireDate;
  final bool? secondaryIsIdExpire;
  final String? secondaryIssueCountryCode;
  final String? secondaryIssueCountryValue;
  final String? nameOnCard;
  final String? encryptEmailAddress;
  final String? medicareCardType;
  final String? medicareRefno;
  final String? medicareName;
  final String? medicareDateOfExpiry;

  factory IdentificationInfo.fromJson(Map<String, dynamic> json) => IdentificationInfo(
        idTypeCode: json["id_type_code"],
        idTypeValue: json["id_type_value"],
        idNumber: json["id_number"],
        idTypeOption: json["id_type_option"],
        issueDate: json["issue_date"],
        expireDate: json["expire_date"],
        isIdExpire: json["is_id_expire"],
        issueCountryCode: json["issue_country_code"],
        issueCountryValue: json["issue_country_value"],
        issueCountryState: json["issue_country_state"],
        idIssueJurisdiction: json["iD_Issuing_Jurisdiction"],
        idIssueJurisdictionOther: json["iD_Issuing_Jurisdiction_other"],
        senderType: json["sender_type"],
        customerId: json["customer_id"],
        secondaryIdTypeCode: json["secondary_id_type_code"],
        secondaryIdTypeValue: json["secondary_id_type_value"],
        secondaryIdNumber: json["secondary_id_number"],
        secondaryIssueDate: json["secondary_issue_date"],
        secondaryExpireDate: json["secondary_expire_date"],
        secondaryIsIdExpire: json["secondary_is_id_expire"],
        secondaryIssueCountryCode: json["secondary_issue_country_code"],
        secondaryIssueCountryValue: json["secondary_issue_country_value"],
        nameOnCard: json["nameOnCard"],
        encryptEmailAddress: json["EncryptEmailAddress"],
        medicareCardType: json["medicare_card_type"],
        medicareRefno: json["medicare_refno"],
        medicareName: json["medicare_name"],
        medicareDateOfExpiry: json["medicare_date_of_expiry"],
      );
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

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        lastName: json["last_name"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName2: json["last_name2"],
      );
}
