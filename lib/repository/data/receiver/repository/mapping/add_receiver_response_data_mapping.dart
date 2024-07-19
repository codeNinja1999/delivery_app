import 'package:fresh_fold_delivery/repository/data/core/string_format_utils.dart';
import 'package:fresh_fold_delivery/repository/data/receiver/model/add_receiver/add_receiver_response_model.dart';
import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalogs.dart';
import 'package:fresh_fold_delivery/repository/domain/common/model/name.dart';
import 'package:fresh_fold_delivery/repository/domain/receiver/entities/receiver.dart';
import 'package:fresh_fold_delivery/repository/domain/receiver/entities/receiver_contact_info.dart';
import 'package:fresh_fold_delivery/repository/domain/receiver/entities/receiver_identification_info.dart';
import 'package:fresh_fold_delivery/repository/domain/receiver/entities/receiver_payout_info.dart';
import 'package:fresh_fold_delivery/repository/domain/receiver/entities/receiver_personal_info.dart';

import '../../../common/common.dart';

extension BeneficiaryResponseDataMapping on BeneficiaryInfoResponse {
  DetailedReceiver get toDomain {
    final isCorporateTransfer = corporateTransfer == true;
    final receiverType = (isCorporateTransfer) ? "corporate" : "individual";
    final englishName = Name(
      firstName: nameEnglish?.firstName,
      middleName: nameEnglish?.middleName,
      lastName: nameEnglish?.lastName,
    );

    final payoutInformation = DetailedReceiverPayoutInfo(
        id: beneficiaryDetailResponse?.beneficiaryIdNumber ?? "",
        receivingCountry: ReceivingCountry(
            id: beneficiaryDetailResponse?.countryCode ?? "", value: beneficiaryDetailResponse?.countryName ?? ""),
        nationality:
            Catalog(id: beneficiaryDetailResponse?.countryCode ?? "", value: beneficiaryDetailResponse?.countryName ?? ""),
        bank: Bank(
            id: beneficiaryDetailResponse?.bankCode ?? "",
            value: beneficiaryDetailResponse?.bankName ?? "",
            methodCode: beneficiaryDetailResponse?.remittanceMethodCode ?? ""),
        payoutPartner: Catalog(id: furikomiRemittance?.bankCode ?? "", value: furikomiRemittance?.bankName ?? ""),
        mode: PaymentMode(
            id: beneficiaryDetailResponse?.depositTypeData ?? "",
            value: beneficiaryDetailResponse?.remittanceMethodName ?? "",
            receiverCurrency: beneficiaryDetailResponse?.receiveCurrencyCode,
            remittanceMethodType: beneficiaryDetailResponse?.remittanceMethodType ?? ""),
        currency: Catalog(
            id: beneficiaryDetailResponse?.receiveCurrencyCode ?? "",
            value: beneficiaryDetailResponse?.receiveCurrencyCode ?? ""),
        headOffice: Catalog(id: beneficiaryDetailResponse?.bankCode ?? "", value: beneficiaryDetailResponse?.bankName ?? ""),
        // branch: beneficiaryDetailResponse?.branchName ?? "",
        // branchCode: beneficiaryDetailResponse?.branchCode ?? "",
        branch: Branch(id: beneficiaryDetailResponse?.branchCode ?? "", value: beneficiaryDetailResponse?.branchName ?? ""),
        accountType: Catalog(
            id: beneficiaryDetailResponse?.remittanceMethodTypeCode ?? "",
            value: beneficiaryDetailResponse?.remittanceMethodType ?? ""),
        accountNumber: beneficiaryDetailResponse?.accountNumber ?? "");
    final responseData = DetailedReceiver(
      id: beneficiaryId,
      receiverType: Catalog(id: receiverType, value: receiverType),
      personalInfo: ReceiverPersonalInfo(
          beneficiaryNativeFirstName: beneficiaryDetailResponse?.beneficiaryNativeFirstName,
          beneficiaryNativeLastName: beneficiaryDetailResponse?.beneficiaryNativeLastName,
          nameEnglish: englishName,
          mobile: mobileNumber,
          // Name(
          //     firstName: nameEnglish?.firstName, middleName: nameEnglish?.middleName, lastName: nameEnglish?.lastName),
          nameAlternative: null,
          fullName: StringFormatUtils.mergeName(englishName),
          // (middleName != null && middleName != "") ? "$firstName $middleName $lastName" : "$firstName $lastName",
          nickName: beneficiaryDetailResponse?.transferNickname,
          gender: Catalog(id: gender ?? "", value: gender != null ? getGenderValue(gender) : ""),
          dateOfBirth: birthday,
          receivingCountry: Country(
              id: beneficiaryDetailResponse?.countryCode ?? "",
              value: beneficiaryDetailResponse?.countryName ?? "",
              telephoneCode: beneficiaryDetailResponse?.countryCode ?? ""),
          nationality: Country(
              id: countryOfOriginCode ?? "", value: countryOfOriginValue ?? "", telephoneCode: countryOfOriginCode ?? ""),
          occupation: Catalog(
              id: beneficiaryDetailResponse?.beneficiaryOccupationId ?? "",
              value: beneficiaryDetailResponse?.beneficiaryOccupation ?? ""),
          occupationAlternative: beneficiaryDetailResponse?.beneficiaryOccupationOther,
          relation: Catalog(id: relationshipWithBeneficiaryCode ?? "", value: relationshipWithBeneficiaryValue ?? ""),
          relationAlternative: relationshipWithBeneficiary,
          purposeOfRemittance: Catalog(id: remittanceReasonCode ?? "", value: remittanceReasonDetail ?? ""),
          purposeOfRemittanceAlternative: remittanceReasonDetail ?? ""),
      contactInfo: ReceiverContactInfo(
        receivingCountry: ReceivingCountry(
          id: beneficiaryDetailResponse?.countryCode ?? "",
          value: beneficiaryDetailResponse?.countryName ?? "",
          currencyCode: beneficiaryDetailResponse?.receiveCurrencyCode ?? "",
        ),
        postalCode: addressInfoResponse?.zipCode ?? "",
        receiverNativeAddress: addressInfoResponse?.receiverNativeAddress,
        state: States(
            id: addressInfoResponse?.addressStateProvince ?? "", value: addressInfoResponse?.addressStateProvince ?? ""),
        stateAlternative: addressInfoResponse?.addressStateProvince ?? "",
        city: Catalog(id: addressInfoResponse?.addressCityTown ?? "", value: addressInfoResponse?.addressCityTown ?? ""),
        streetAddress: addressInfoResponse?.addressStreet ?? "",
        address2: addressInfoResponse?.addressStreet,
        emailAddress: emailAddress,
        mobileNumber: mobileNumber,
        telephoneNumber: telephoneNumber,
      ),
      identificationInfo: ReceiverIdentificationInfo(
        idType: Catalog(
            id: beneficiaryDetailResponse?.beneficiaryIdType ?? "",
            value: beneficiaryDetailResponse?.beneficiaryIdTypeName ?? ""),
        idNumber: beneficiaryDetailResponse?.beneficiaryIdNumber ?? "",
        issuedDate: beneficiaryDetailResponse?.beneficiaryidIssueDate ?? "",
        expiryDate: beneficiaryDetailResponse?.beneficiaryidExpiryDate ?? "",
        issuedCountry: Catalog(
            id: beneficiaryDetailResponse?.beneficiaryIdIssuedCountryCode ?? "",
            value: beneficiaryDetailResponse?.countryName ?? ""),
        issuedCountryState: Catalog(
            id: beneficiaryDetailResponse?.beneficiaryIdIssuedCountryCode ?? "",
            value: beneficiaryDetailResponse?.countryName ?? ""),
      ),
      defaultPayoutInfo: payoutInformation,
      payoutList: null,
    );
    return responseData;
  }
}
