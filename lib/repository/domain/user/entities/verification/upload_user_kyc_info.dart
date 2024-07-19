import 'package:fresh_fold_delivery/repository/repository.dart';

class UploadUserKycInfo {
  final KycDocumentInfo? primaryDocumentInfo;
  final KycDocumentInfo? secondaryDocumentInfo;
  final KycDocumentInfo? additionalDocumentInfo;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? cardName;
  final String? cardColor;
  final Country? nationality;
  final Country? issuedCountry;
  final Catalog? state;
  final Catalog? gender;
  final String? zipCode;
  final String? idIssueDate;
  final String? idExpiryDate;
  final Catalog? documentIdType;
  final String? documentIdNumber;
  final String? dateOfBirth;
  final String? streetAddress;
  final String? japaneseStreetAddress;
  final String? japaneseSenderAddress;
  final String? city;
  final String? profileImage;
  final String? selfieWithImageId;
  final String? frontImageName;
  final String? backImageName;
  final String? additionalImageName;
  final String? additionalCardNumber;
  final String? myNumber;
  final Catalog? occupation;
  final Catalog? idIssueJurisdiction;
  final String? idIssueJurisdictionOther;
  final Catalog? idVisaType;

  UploadUserKycInfo({
    this.myNumber,
    this.idIssueJurisdiction,
    this.idVisaType,
    this.cardName,
    this.gender,
    this.cardColor,
    this.documentIdNumber,
    this.documentIdType,
    this.firstName,
    this.middleName,
    this.lastName,
    this.nationality,
    this.issuedCountry,
    this.state,
    this.city,
    this.zipCode,
    this.dateOfBirth,
    this.idExpiryDate,
    this.idIssueDate,
    this.selfieWithImageId,
    this.frontImageName,
    this.backImageName,
    this.additionalImageName,
    this.streetAddress,
    this.japaneseStreetAddress,
    this.japaneseSenderAddress,
    this.idIssueJurisdictionOther,
    this.profileImage,
    this.occupation,
    this.additionalCardNumber,
    this.primaryDocumentInfo,
    this.secondaryDocumentInfo,
    this.additionalDocumentInfo,
  });
}

class KycDocumentInfo {
  final Country? idIssuingCountry;
  final Catalog? idIssueState;
  final Catalog? idType;
  final String? idNumber;
  final String? expiryDate;
  final String? issueDate;

  KycDocumentInfo({
    this.idIssueState,
    this.idType,
    this.idNumber,
    this.idIssuingCountry,
    this.expiryDate,
    this.issueDate,
  });
}
