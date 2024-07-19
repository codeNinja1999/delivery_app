import 'package:fresh_fold_delivery/repository/data/user/models/level1_kyc/level_one_kyc_request_model.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/registration/upload_level_one_kyc_info.dart';

extension UploadLevelOneKycDocumentRequestMapping on UploadLevelOneKycDocumentInfo {
  LevelOneKycRequestModel toRequestData() {
    final kycOnedata = LevelOneKycRequestModel(
      imageSelfie: imgSelfie,
      imageSignature: imgSignature,
      imageBirthCertificate: imgBirthCertificate,
      imageParentConsent: imgParentConsent,
      imageParentGovId: imgParentGovId,
    );
    return kycOnedata;
  }
}
