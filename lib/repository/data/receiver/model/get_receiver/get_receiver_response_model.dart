import 'dart:convert';

GetReceiverResponse getReceiverResponseFromJson(String str) => GetReceiverResponse.fromJson(json.decode(str));

String getReceiverResponseToJson(GetReceiverResponse data) => json.encode(data.toJson());

class GetReceiverResponse {
  GetReceiverResponse({
    this.totalDataNo,
    this.resultList,
    this.processResult,
    this.errorList,
    this.warningList,
  });

  int? totalDataNo;
  List<ResultList>? resultList;
  bool? processResult;
  List<ErrorList>? errorList;
  List<WarningList>? warningList;

  factory GetReceiverResponse.fromJson(Map<String, dynamic> json) => GetReceiverResponse(
        totalDataNo: json["total_data_no"],
        resultList: List<ResultList>.from(json["result_list"].map((x) => ResultList.fromJson(x))),
        processResult: json["process_result"],
        errorList: List<ErrorList>.from(json["error_list"].map((x) => ErrorList.fromJson(x))),
        warningList: List<WarningList>.from(json["warning_list"].map((x) => WarningList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_data_no": totalDataNo,
        "result_list": List<dynamic>.from(resultList!.map((x) => x.toJson())),
        "process_result": processResult,
        "error_list": List<dynamic>.from(errorList!.map((x) => x.toJson())),
        "warning_list": List<dynamic>.from(warningList!.map((x) => x.toJson())),
      };
}

class ErrorList {
  ErrorList({
    this.errorCode,
    this.errorMessage,
  });

  String? errorCode;
  String? errorMessage;

  factory ErrorList.fromJson(Map<String, dynamic> json) => ErrorList(
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_message": errorMessage,
      };
}

class ResultList {
  ResultList({
    this.beneficiaryId,
    this.lastRemittanceTs,
    this.lastRemittanceAmount,
    this.furikomiRemittance,
    this.beneficiaryDetail,
    this.addressInfo,
    this.nameEnglish,
    this.birthday,
    this.gender,
    this.telephoneNumber,
    this.mobileNumber,
    this.isTransactionComplete,
    this.emailAddress,
    this.relationshipWithBeneficiaryCode,
    this.relationshipWithBeneficiaryValue,
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
    this.beneficiaryAccNameConfirmationStatus,
    this.corporateTransfer,
    this.corporateName,
    this.receiverRegistrationNumber,
    this.filteringResult,
    this.remitCardNumber,
    this.lastUpdateTs,
  });

  String? beneficiaryId;
  String? lastRemittanceTs;
  String? lastRemittanceAmount;
  FurikomiRemittance? furikomiRemittance;
  BeneficiaryDetail? beneficiaryDetail;
  AddressInfo? addressInfo;
  NameEnglish? nameEnglish;
  String? birthday;
  String? gender;
  String? telephoneNumber;
  String? mobileNumber;
  String? isTransactionComplete;
  String? emailAddress;
  String? relationshipWithBeneficiaryCode;
  String? relationshipWithBeneficiaryValue;
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
  bool? beneficiaryAccNameConfirmationStatus;
  bool? corporateTransfer;
  String? corporateName;
  String? receiverRegistrationNumber;
  bool? filteringResult;
  String? remitCardNumber;
  String? lastUpdateTs;

  factory ResultList.fromJson(Map<String, dynamic> json) => ResultList(
        beneficiaryId: json["beneficiary_id"],
        lastRemittanceTs: json["last_remittance_ts"],
        lastRemittanceAmount: json["last_remittance_amount"],
        furikomiRemittance: FurikomiRemittance.fromJson(json["furikomi_remittance"]),
        beneficiaryDetail: BeneficiaryDetail.fromJson(json["beneficiary_detail"]),
        addressInfo: AddressInfo.fromJson(json["address_info"]),
        nameEnglish: NameEnglish.fromJson(json["name_english"]),
        birthday: json["birthday"],
        gender: json["gender"],
        telephoneNumber: json["telephone_number"],
        mobileNumber: json["mobile_number"],
        isTransactionComplete: json["is_transaction_complete"],
        emailAddress: json["email_address"],
        relationshipWithBeneficiaryCode: json["relationship_with_beneficiary_code"],
        relationshipWithBeneficiaryValue: json["relationship_with_beneficiary_value"],
        relationshipWithBeneficiaryDetail: json["relationship_with_beneficiary_detail"],
        remittanceReasonCode: json["remittance_reason_code"],
        remittanceReasonDetail: json["remittance_reason_detail"],
        countryOfOriginCode: json["country_of_origin_code"],
        countryOfOriginValue: json["country_of_origin_value"],
        countryOfShipmentCode: json["country_of_shipment_code"],
        placeOfShipment: json["place_of_shipment"],
        message1: json["message1"],
        message2: json["message2"],
        secretQuestionCode: json["secret_question_code"],
        answer: json["answer"],
        beneficiaryAccNameConfirmationStatus: json["beneficiary_acc_name_confirmation_status"],
        corporateTransfer: json["corporate_transfer"],
        corporateName: json["corporate_name"],
        receiverRegistrationNumber: json["receiver_registration_number"],
        filteringResult: json["filtering_result"],
        remitCardNumber: json["remit_card_number"],
        lastUpdateTs: json["last_update_ts"],
      );

  Map<String, dynamic> toJson() => {
        "beneficiary_id": beneficiaryId,
        "last_remittance_ts": lastRemittanceTs,
        "last_remittance_amount": lastRemittanceAmount,
        "furikomi_remittance": furikomiRemittance?.toJson(),
        "beneficiary_detail": beneficiaryDetail?.toJson(),
        "address_info": addressInfo?.toJson(),
        "name_english": nameEnglish?.toJson(),
        "birthday": birthday,
        "gender": gender,
        "telephone_number": telephoneNumber,
        "mobile_number": mobileNumber,
        "is_transaction_complete": isTransactionComplete,
        "email_address": emailAddress,
        "relationship_with_beneficiary_code": relationshipWithBeneficiaryCode,
        "relationship_with_beneficiary_value": relationshipWithBeneficiaryValue,
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
        "beneficiary_acc_name_confirmation_status": beneficiaryAccNameConfirmationStatus,
        "corporate_transfer": corporateTransfer,
        "corporate_name": corporateName,
        "receiver_registration_number": receiverRegistrationNumber,
        "filtering_result": filteringResult,
        "remit_card_number": remitCardNumber,
        "last_update_ts": lastUpdateTs,
      };
}

class AddressInfo {
  AddressInfo({
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

  factory AddressInfo.fromJson(Map<String, dynamic> json) => AddressInfo(
        zipCode: json["zip_code"],
        addressCountryCode: json["address_country_code"],
        addressStateProvince: json["address_state_province"],
        addressCityTown: json["address_city_town"],
        addressStreet: json["address_street"],
        receiverNativeAddress: json["receiver_native_address"],
      );

  Map<String, dynamic> toJson() => {
        "zip_code": zipCode,
        "address_country_code": addressCountryCode,
        "address_state_province": addressStateProvince,
        "address_city_town": addressCityTown,
        "address_street": addressStreet,
        "receiver_native_address": receiverNativeAddress,
      };
}

class BeneficiaryDetail {
  BeneficiaryDetail({
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
    this.beneficiaryOccupation,
    this.beneficiaryOccupationId,
    this.beneficiaryOccupationOther,
    this.beneficiaryidExpiryDate,
    this.beneficiaryidIssueDate,
    this.receiveCurrencyCode,
    this.subBranchName,
    this.beneficiaryIdNumber,
    this.beneficiaryIdType,
    this.beneficiaryIdTypeName,
    this.beneficiaryNativeFirstName,
    this.beneficiaryNativeLastName,
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
  String? branchCode;
  String? beneficiaryNativeFirstName;
  String? beneficiaryNativeLastName;
  String? beneficiaryOccupationId;
  String? beneficiaryOccupation;
  String? beneficiaryOccupationOther;
  String? beneficiaryidExpiryDate;
  String? beneficiaryidIssueDate;
  String? accountNumber;
  String? bankCode;
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

  factory BeneficiaryDetail.fromJson(Map<String, dynamic> json) => BeneficiaryDetail(
        countryCode: json["country_code"],
        countryName: json["country_name"],
        remittanceMethodCode: json["remittance_method_code"],
        remittanceMethodName: json["remittance_method_name"],
        remittanceMethodTypeCode: json["remittance_method_type_code"],
        transferNickname: json["transfer_nickname"],
        bankName: json["bank_name"],
        branchName: json["branch_name"],
        accountNumber: json["account_number"],
        bankCode: json["bank_code"],
        branchCode: json["branch_code"],
        beneficiaryNativeFirstName: json["beneficiary_native_firstname"],
        beneficiaryNativeLastName: json["beneficiary_native_lastname"],
        beneficiaryOccupation: json["beneficiary_occupation"],
        beneficiaryOccupationId: json["beneficiary_occupation_id"],
        beneficiaryOccupationOther: json["beneficiary_occupation_other"],
        beneficiaryidExpiryDate: json["beneficiary_id_expiry_date"],
        beneficiaryidIssueDate: json["beneficiary_id_issue_date"],
        receiveCurrencyCode: json["receive_currency_code"],
        subBranchName: json["sub_branch_name"],
        beneficiaryIdNumber: json["beneficiary_id_number"],
        beneficiaryIdType: json["beneficiary_id_type"],
        beneficiaryIdTypeName: json["beneficiary_id_type_name"],
        beneficiaryIdIssuedCountryCode: json["beneficiary_id_issued_country_code"],
        usingRemittance: json["using_remittance"],
        remitcardRemittance: json["remitcard_remittance"],
        depositTypeCode: json["deposit_type_code"],
        depositTypeValue: json["deposit_type_value"],
        depositTypeData: json["deposit_type_data"],
        remittanceMethodType: json["remittance_method_type"],
      );

  Map<String, dynamic> toJson() => {
        "country_code": countryCode,
        "country_name": countryName,
        "remittance_method_code": remittanceMethodCode,
        "remittance_method_name": remittanceMethodName,
        "remittance_method_type_code": remittanceMethodTypeCode,
        "transfer_nickname": transferNickname,
        "bank_name": bankName,
        "branch_name": branchName,
        "account_number": accountNumber,
        "bank_code": bankCode,
        "branch_code": branchCode,
        "beneficiary_native_firstname": beneficiaryNativeFirstName,
        "beneficiary_native_lastname": beneficiaryNativeLastName,
        "beneficiary_occupation_id": beneficiaryOccupationId,
        "beneficiary_occupation": beneficiaryOccupation,
        "beneficiary_occupation_other": beneficiaryOccupationOther,
        "beneficiary_id_expiry_date": beneficiaryidExpiryDate,
        "beneficiary_id_issue_date": beneficiaryidIssueDate,
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

class FurikomiRemittance {
  FurikomiRemittance({
    this.bankName,
    this.bankCode,
    this.branchName,
    this.branchCode,
    this.accountNumber,
    this.depositTypeCode,
    this.accountName,
  });

  String? bankName;
  String? bankCode;
  String? branchName;
  String? branchCode;
  String? accountNumber;
  String? depositTypeCode;
  String? accountName;

  factory FurikomiRemittance.fromJson(Map<String, dynamic> json) => FurikomiRemittance(
        bankName: json["bank_name"],
        bankCode: json["bank_code"],
        branchName: json["branch_name"],
        branchCode: json["branch_code"],
        accountNumber: json["account_number"],
        depositTypeCode: json["deposit_type_code"],
        accountName: json["account_name"],
      );

  Map<String, dynamic> toJson() => {
        "bank_name": bankName,
        "bank_code": bankCode,
        "branch_name": branchName,
        "branch_code": branchCode,
        "account_number": accountNumber,
        "deposit_type_code": depositTypeCode,
        "account_name": accountName,
      };
}

class NameEnglish {
  NameEnglish({
    this.firstName,
    this.middleName,
    this.lastName,
    this.lastName2,
  });

  String? firstName;
  String? middleName;
  String? lastName;
  String? lastName2;

  factory NameEnglish.fromJson(Map<String, dynamic> json) => NameEnglish(
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        lastName2: json["last_name2"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "last_name2": lastName2,
      };
}

class WarningList {
  WarningList({
    this.warningCode,
    this.warningMessage,
  });

  String? warningCode;
  String? warningMessage;

  factory WarningList.fromJson(Map<String, dynamic> json) => WarningList(
        warningCode: json["warning_code"],
        warningMessage: json["warning_message"],
      );

  Map<String, dynamic> toJson() => {
        "warning_code": warningCode,
        "warning_message": warningMessage,
      };
}
