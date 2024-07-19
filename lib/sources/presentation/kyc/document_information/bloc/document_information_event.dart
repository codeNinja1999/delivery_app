part of 'document_information_bloc.dart';

abstract class DocumentInformationEvent {}

class GetCatalog extends DocumentInformationEvent {}

class IDNumberChanged extends DocumentInformationEvent {
  final String idNumber;
  IDNumberChanged(this.idNumber);
}

class IdIssueCountrySelected extends DocumentInformationEvent {
  final Country issueCountry;
  IdIssueCountrySelected(this.issueCountry);
}

class IDIssueDateSelected extends DocumentInformationEvent {
  final String issueDate;
  IDIssueDateSelected(this.issueDate);
}

class IDExpiryDateSelected extends DocumentInformationEvent {
  final String expiryDate;
  IDExpiryDateSelected(this.expiryDate);
}

class IdIssueJurisdictionSelected extends DocumentInformationEvent {
  IdIssueJurisdictionSelected(this.idIssueJurisdiction);
  final Catalog idIssueJurisdiction;
}

class IdIssueJurisdictionOtherChanged extends DocumentInformationEvent {
  IdIssueJurisdictionOtherChanged(this.idIssueJurisdictionOther);
  final String? idIssueJurisdictionOther;
}

class DocumentInfoSubscriptionRequested extends DocumentInformationEvent {}

class UploadKycInfo extends DocumentInformationEvent {
  final UploadUserKycInfo? uploadUserKycInfo;
  final Country? nationality;
  final Catalog? state;
  final String? zipCode;
  final String? city;
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final Catalog? gender;
  final Catalog? documentIdType;
  final Catalog? visaType;
  final String? streetAddress;
  final String? japaneseStreetAddress;
  final String? japaneseSenderAddress;
  final String? dateOfBirth;
  final Catalog? occupation;

  UploadKycInfo({
    this.uploadUserKycInfo,
    this.nationality,
    this.state,
    this.gender,
    this.zipCode,
    this.city,
    this.firstName,
    this.lastName,
    this.middleName,
    this.documentIdType,
    this.visaType,
    this.japaneseStreetAddress,
    this.japaneseSenderAddress,
    this.streetAddress,
    this.dateOfBirth,
    this.occupation,
  });
}
