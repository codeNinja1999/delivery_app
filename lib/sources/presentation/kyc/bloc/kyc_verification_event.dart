part of 'kyc_verification_bloc.dart';

abstract class KycVerificationEvent {}

class ClearPrimaryDocument extends KycVerificationEvent {}

class ClearSecondaryDocument extends KycVerificationEvent {}

class ClearAdditionalDocument extends KycVerificationEvent {}

class UserInfoSubscription extends KycVerificationEvent {}

class ClearSelfie extends KycVerificationEvent {}

class SaveAzureInfo extends KycVerificationEvent {
  final AzureInfo? azureInfo;
  SaveAzureInfo(this.azureInfo);
}

class SavePersonalInfo extends KycVerificationEvent {
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final Country? nationality;
  final String? dateOfBirth;
  final Catalog? occupation;
  final Catalog? gender;
  final Catalog? visaType;

  SavePersonalInfo({
    this.firstName,
    this.middleName,
    this.lastName,
    this.nationality,
    this.dateOfBirth,
    this.occupation,
    this.visaType,
    this.gender,
  });
}

class SaveAddressInfo extends KycVerificationEvent {
  final String? state;
  final String? zipCode;
  final String? city;
  final String? streetAddress;
  final String? japaneseStreetAddress;
  final String? japaneseSenderAddress;
  SaveAddressInfo({
    this.state,
    this.streetAddress,
    this.zipCode,
    this.city,
    this.japaneseStreetAddress,
    this.japaneseSenderAddress,
  });
}

class SaveDocumentType extends KycVerificationEvent {
  final Catalog? documentType;
  SaveDocumentType({this.documentType});
}

class SaveDocumentInformation extends KycVerificationEvent {
  final String? idNumber;
  final String? idIssueDate;
  final String? idExpiryDate;
  final Country? idIssueCountry;
  SaveDocumentInformation({
    this.idNumber,
    this.idIssueDate,
    this.idExpiryDate,
    this.idIssueCountry,
  });
}

class SaveDocumentInfo extends KycVerificationEvent {
  final UploadUserKycInfo verificationInfo;
  SaveDocumentInfo(this.verificationInfo);
}

class SaveSecondaryImage extends KycVerificationEvent {
  final File secondaryImage;
  SaveSecondaryImage(this.secondaryImage);
}

class GetLocalImage extends KycVerificationEvent {
  final ScanType scanFor;
  final ScanBy scanBy;
  GetLocalImage(this.scanFor, this.scanBy);
}

class SaveDocumentDetails extends KycVerificationEvent {
  final UploadUserKycInfo uploadUserKycInfo;
  SaveDocumentDetails(this.uploadUserKycInfo);
}

class SaveFrontDocument extends KycVerificationEvent {
  final String frontDocument;
  SaveFrontDocument(this.frontDocument);
}

class SaveBackDocument extends KycVerificationEvent {
  final String backDocument;
  SaveBackDocument(this.backDocument);
}

class SaveThicknessDocument extends KycVerificationEvent {
  final String thickness;
  SaveThicknessDocument(this.thickness);
}
class SaveSelfieDocument extends KycVerificationEvent {
  final String selfie;
  SaveSelfieDocument(this.selfie);
}
