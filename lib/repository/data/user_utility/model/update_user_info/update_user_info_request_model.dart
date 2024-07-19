class UserUpdateInfoRequestModel {
  UserUpdateInfoRequestModel({
    this.memberInfo,
    this.tradePassword,
  });

  MemberInfo? memberInfo;
  String? tradePassword;

  Map<String, dynamic> toJson() => {
        "member_info": memberInfo?.toJson(),
        "trade_password": tradePassword,
      };
}

class MemberInfo {
  MemberInfo({
    this.lastUpdateTs,
    this.isPostalCodeSpecified,
    this.emailAddress2,
    this.campaignCode,
    this.withdrawalBankAcc,
    this.addressInfo,
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
  });

  String? lastUpdateTs;
  bool? isPostalCodeSpecified;
  String? emailAddress2;
  String? campaignCode;
  WithdrawalBankAcc? withdrawalBankAcc;
  AddressInfo? addressInfo;
  String? nationality;
  String? gender;
  String? birthday;
  String? mobilePhoneNumber;
  String? homePhoneNumber;
  String? occupationCode;
  String? occupationOthers;
  String? sourceOfFundsCode;
  String? sourceOfFundsOthers;
  String? emailAddress1;
  String? userName;
  String? password;
  String? emailDisplayLanguage;
  Name? nameEnglish;
  Name? nameAlternate;

  Map<String, dynamic> toJson() => {
        "last_update_ts": lastUpdateTs,
        "is_postal_code_specified": isPostalCodeSpecified,
        "email_address2": emailAddress2,
        "campaign_code": campaignCode,
        "withdrawal_bank_acc": withdrawalBankAcc?.toJson(),
        "address_info": addressInfo?.toJson(),
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
  });

  String? masterCode;
  String? addressZipcode;
  String? addressStreet;
  String? addressCity;
  String? addressStateJpn;
  String? addressState;
  String? addressInput;

  Map<String, dynamic> toJson() => {
        "master_code": masterCode,
        "address_zipcode": addressZipcode,
        "address_street": addressStreet,
        "address_city": addressCity,
        "address_state_jpn": addressStateJpn,
        "address_state": addressState,
        "address_input": addressInput,
      };
}

class Name {
  Name({
    this.lastName,
    this.firstName,
    this.middleName,
    this.lastName2,
  });

  String? lastName;
  String? firstName;
  String? middleName;
  String? lastName2;

  Map<String, dynamic> toJson() => {
        "last_name": lastName,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name2": lastName2,
      };
}

class WithdrawalBankAcc {
  WithdrawalBankAcc({
    this.bankCode,
    this.bankName,
    this.branchCode,
    this.branchName,
    this.depositTypeCode,
    this.accountNumber,
    this.accountName,
  });

  String? bankCode;
  String? bankName;
  String? branchCode;
  String? branchName;
  String? depositTypeCode;
  String? accountNumber;
  String? accountName;

  Map<String, dynamic> toJson() => {
        "bank_code": bankCode,
        "bank_name": bankName,
        "branch_code": branchCode,
        "branch_name": branchName,
        "deposit_type_code": depositTypeCode,
        "account_number": accountNumber,
        "account_name": accountName,
      };
}
