import 'package:fresh_fold_delivery/repository/data/user_utility/model/get_userinfo/get_userinfo_reponse_model.dart';
import 'package:fresh_fold_delivery/repository/data/user_utility/mapping/kyc_status_mapping.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

extension UpdateUserInfoReponseMapping on MemberInfo {
  DetailedUser toDomain() {
    final englishName = EnglishName(
      firstName: nameEnglish?.firstName,
      middleName: nameEnglish?.middleName,
      lastName: nameEnglish?.lastName,
    );

    final userPersonalInfo = UserPersonalInfo(
      nameEnglish: englishName,
      fullName: StringFormatUtils.mergeNames(englishName),
      gender: Catalog(id: gender ?? "", value: gender ?? ""),
      dateOfBirth: birthday,
      nationality: Catalog(id: nationality ?? "", value: nationalityName ?? ""),

    );
    final usercontactinfo = ContactInfo(
      country: Catalog(id: addressInfo?.country ?? "", value: addressInfo?.country ?? ""),
      postalCode: addressInfo?.zipCode,
      state: Catalog(id: "", value: addressInfo?.addressState ?? ""),
      city: Catalog(id: "", value: addressInfo?.addressCity ?? ""),
      streetAddress: addressInfo?.addressStreet,
      emailAddress: emailAddress1,
      mobileNumber: mobilePhoneNumber,
      telephoneNumber: homePhoneNumber,
    );
    final identificationInfor = UserIdentificationInfo(
      idType: Catalog(id: identificationInfo?.idTypeCode ?? "", value: identificationInfo?.idTypeValue ?? ""),
      idNumber: identificationInfo?.idNumber,
      issuedDate: identificationInfo?.issueDate,
      expiryDate: identificationInfo?.expireDate,
      issuedCountry: Catalog(
        id: identificationInfo?.issueCountryCode ?? "",
        value: identificationInfo?.issueCountryValue ?? "",
      ),
      idIssueJurisdiction: Catalog(
        id: identificationInfo?.idIssueJurisdiction ?? "",
        value: identificationInfo?.idIssueJurisdiction ?? "",
      ),
      idIssueJurisdictionOther: identificationInfo?.idIssueJurisdictionOther,
      issuedCountryState: Catalog(id: "", value: identificationInfo?.issueCountryState ?? ""),
      referenceNumber: identificationInfo?.medicareRefno ?? "",
      nameAsCard: identificationInfo?.nameOnCard,
      cardColor: identificationInfo?.medicareCardType,
    );
    final walletInfo = UserWalletInfo(
      walletBalance ?? "",
      walletPending,
      lastUpdateTs,
    );

    final DetailedUser detailedUser = DetailedUser(
      userName: userName ?? "",
      id: customerId ?? "",
      status: status(kycStatus ?? ""),
      identificationInfo: identificationInfor,
      contactInfo: usercontactinfo,
      walletInfo: walletInfo,
      personalInfo: userPersonalInfo,
      promotionalCode: campaignCode ?? "",
    );
    final requestData = detailedUser;
    return requestData;
  }
}
