import 'dart:io';

class UploadLevelOneKycDocumentInfo {
  final File? imgSelfie;
  final File? imgSignature;
  final File? imgBirthCertificate;
  final File? imgParentConsent;
  final File? imgParentGovId;

  UploadLevelOneKycDocumentInfo({
    this.imgSelfie,
    this.imgSignature,
    this.imgBirthCertificate,
    this.imgParentConsent,
    this.imgParentGovId,
  });
}
