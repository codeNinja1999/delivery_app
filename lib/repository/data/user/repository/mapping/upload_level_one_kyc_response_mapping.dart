import 'package:fresh_fold_delivery/repository/data/user/models/level1_kyc/level_one_kyc_response_model.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/registration/level_one_kyc_document.dart';

extension UploadLevelOneKycReponseMapping on LevelOneKycResponseModel {
  LevelOneKycDocument toDomain() {
    return LevelOneKycDocument(
      imageSelfie: customerProfileImage?.imageSelfie,
      imageSignature: customerProfileImage?.imageSignature,
      imageBirthCertificate: customerProfileImage?.imageBirthCertificate,
      imageParentConsent: customerProfileImage?.imageParentConsent,
      imageParentGovId: customerProfileImage?.imageParentGovId,
    );
  }
}
