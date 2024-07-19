import 'dart:io';

class LevelOneKycRequestModel {
  final File? imageSelfie;
  final File? imageSignature;
  final File? imageBirthCertificate;
  final File? imageParentConsent;
  final File? imageParentGovId;

  LevelOneKycRequestModel({
    this.imageSelfie,
    this.imageSignature,
    this.imageBirthCertificate,
    this.imageParentConsent,
    this.imageParentGovId,
  });

  Map<String, dynamic> toJson() => {
        "image_selfie": imageSelfie,
        "image_signature": imageSignature,
        "image_birth_certificate": imageBirthCertificate,
        "image_parent_consent": imageParentConsent,
        "image_parent_gov_id": imageParentGovId,
      };
}
