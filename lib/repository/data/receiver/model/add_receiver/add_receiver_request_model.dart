class AddReceiverRequestModel {
  AddReceiverRequestModel({
    this.requiredTradePassword,
    this.remittanceTransactionId,
    this.tradePassword,
    this.beneficiaryInfo,
  });

  bool? requiredTradePassword;
  String? remittanceTransactionId;
  String? tradePassword;
  BeneficiaryInfo? beneficiaryInfo;

  Map<String, dynamic> toJson() => {
        "required_trade_password": requiredTradePassword,
        "remittance_transaction_id": remittanceTransactionId,
        "trade_password": tradePassword,
        "beneficiary_info": beneficiaryInfo!.toJson(),
      };
}

class BeneficiaryInfo {
  BeneficiaryInfo({
    this.birthday,
    this.gender,
    this.telephoneNumber,
    this.mobileNumber,
    this.emailAddress,
    this.relationshipWithBeneficiaryCode,
    this.relationshipWithBeneficiaryDetail,
    this.remittanceReasonCode,
    this.remittanceReasonDetail,
    this.countryOfOriginCode,
    this.countryOfOriginValue,
    this.countryOfShipmentCode,
    this.placeOfShipment,
    this.message1,
    this.message2,
    this.secretQuestionCode,
    this.answer,
    this.isTransactioComplete,
    this.corporateTransfer,
    this.corporateName,
    this.receiverRegistrationNumber,
    this.beneficiaryDetail,
    this.nameEnglish,
    this.addressInfo,
    this.sourceOfFundsCode,
  });

  String? birthday;
  String? gender;
  String? telephoneNumber;
  String? mobileNumber;
  String? emailAddress;
  String? relationshipWithBeneficiaryCode;
  String? relationshipWithBeneficiaryDetail;
  String? remittanceReasonCode;
  String? remittanceReasonDetail;
  String? countryOfOriginCode;
  String? countryOfOriginValue;
  String? countryOfShipmentCode;
  String? placeOfShipment;
  String? message1;
  String? message2;
  String? secretQuestionCode;
  String? answer;
  bool? corporateTransfer;
  String? isTransactioComplete;
  String? corporateName;
  String? receiverRegistrationNumber;
  BeneficiaryDetailRequest? beneficiaryDetail;
  NameEnglishRequest? nameEnglish;
  AddressInfoRequest? addressInfo;
  String? sourceOfFundsCode;

  Map<String, dynamic> toJson() => {
        "birthday": birthday,
        "gender": gender,
        "telephone_number": telephoneNumber,
        "mobile_number": mobileNumber,
        "email_address": emailAddress,
        "relationship_with_beneficiary_code": relationshipWithBeneficiaryCode,
        "relationship_with_beneficiary_detail": relationshipWithBeneficiaryDetail,
        "remittance_reason_code": remittanceReasonCode,
        "remittance_reason_detail": remittanceReasonDetail,
        "country_of_origin_code": countryOfOriginCode,
        "country_of_origin_value": countryOfOriginValue,
        "country_of_shipment_code": countryOfShipmentCode,
        "place_of_shipment": placeOfShipment,
        "message1": message1,
        "message2": message2,
        "secret_question_code": secretQuestionCode,
        "answer": answer,
        "isTransactioComplete": isTransactioComplete,
        "corporate_transfer": corporateTransfer,
        "corporate_name": corporateName,
        "receiver_registration_number": receiverRegistrationNumber,
        "beneficiary_detail": beneficiaryDetail!.toJson(),
        "name_english": nameEnglish!.toJson(),
        "address_info": addressInfo!.toJson(),
        "source_of_funds_code": sourceOfFundsCode,
      };
}

class AddressInfoRequest {
  AddressInfoRequest({
    this.zipCode,
    this.addressCountryCode,
    this.addressStateProvince,
    this.addressCityTown,
    this.addressStreet,
    this.receiverNativeAddress,
  });

  String? zipCode;
  String? addressCountryCode;
  String? addressStateProvince;
  String? addressCityTown;
  String? addressStreet;
  String? receiverNativeAddress;

  Map<String, dynamic> toJson() => {
        "zip_code": zipCode,
        "address_country_code": addressCountryCode,
        "address_state_province": addressStateProvince,
        "address_city_town": addressCityTown,
        "address_street": addressStreet,
        "receiver_native_address": receiverNativeAddress,
      };
}

class BeneficiaryDetailRequest {
  BeneficiaryDetailRequest({
    this.countryCode,
    this.countryName,
    this.remittanceMethodCode,
    this.remittanceMethodName,
    this.remittanceMethodTypeCode,
    this.transferNickname,
    this.bankName,
    this.branchName,
    this.accountNumber,
    this.bankCode,
    this.branchCode,
    this.beneficiaryidExpiryDate,
    this.beneficiaryidIssueDate,
    this.receiveCurrencyCode,
    this.beneficiaryNativeFirstName,
    this.beneficiaryNativeLastName,
    this.subBranchName,
    this.beneficiaryOccupation,
    this.beneficiaryOccupationOther,
    this.beneficiaryIdNumber,
    this.beneficiaryIdType,
    this.beneficiaryIdTypeName,
    this.beneficiaryIdIssuedCountryCode,
    this.usingRemittance,
    this.remitcardRemittance,
    this.depositTypeCode,
    this.depositTypeValue,
    this.depositTypeData,
    this.remittanceMethodType,
  });

  String? countryCode;
  String? countryName;
  String? remittanceMethodCode;
  String? remittanceMethodName;
  String? remittanceMethodTypeCode;
  String? transferNickname;
  String? bankName;
  String? branchName;
  String? accountNumber;
  String? bankCode;
  String? beneficiaryOccupation;
  String? beneficiaryOccupationOther;
  String? branchCode;
  String? beneficiaryNativeFirstName;
  String? beneficiaryNativeLastName;
  String? beneficiaryidExpiryDate;
  String? beneficiaryidIssueDate;
  String? receiveCurrencyCode;
  String? subBranchName;
  String? beneficiaryIdNumber;
  String? beneficiaryIdType;
  String? beneficiaryIdTypeName;
  String? beneficiaryIdIssuedCountryCode;
  bool? usingRemittance;
  bool? remitcardRemittance;
  String? depositTypeCode;
  String? depositTypeValue;
  String? depositTypeData;
  String? remittanceMethodType;

  Map<String, dynamic> toJson() => {
        "country_code": countryCode,
        "country_name": countryName,
        "remittance_method_code": remittanceMethodCode,
        "remittance_method_name": remittanceMethodName,
        "remittance_method_type_code": remittanceMethodTypeCode,
        "transfer_nickname": transferNickname,
        "bank_name": bankName,
        "branch_name": branchName,
        "beneficiary_native_firstname": beneficiaryNativeFirstName,
        "beneficiary_native_lastname": beneficiaryNativeLastName,
        "beneficiary_id_issue_date": beneficiaryidIssueDate,
        "beneficiary_id_expiry_date": beneficiaryidExpiryDate,
        "account_number": accountNumber,
        "bank_code": bankCode,
        "branch_code": branchCode,
        "beneficiary_occupation": beneficiaryOccupation,
        "beneficiary_occupation_other": beneficiaryOccupationOther,
        "receive_currency_code": receiveCurrencyCode,
        "sub_branch_name": subBranchName,
        "beneficiary_id_number": beneficiaryIdNumber,
        "beneficiary_id_type": beneficiaryIdType,
        "beneficiary_id_type_name": beneficiaryIdTypeName,
        "beneficiary_id_issued_country_code": beneficiaryIdIssuedCountryCode,
        "using_remittance": usingRemittance,
        "remitcard_remittance": remitcardRemittance,
        "deposit_type_code": depositTypeCode,
        "deposit_type_value": depositTypeValue,
        "deposit_type_data": depositTypeData,
        "remittance_method_type": remittanceMethodType,
      };
}

class NameEnglishRequest {
  NameEnglishRequest({
    this.firstName,
    this.middleName,
    this.lastName,
    this.lastName2,
  });

  String? firstName;
  String? middleName;
  String? lastName;
  String? lastName2;

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "last_name2": lastName2,
      };
}
