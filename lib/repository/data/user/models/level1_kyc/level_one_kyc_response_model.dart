class LevelOneKycResponseModel {
  LevelOneKycResponseModel({
    this.customerProfileImage,
    this.processResult,
    this.errorList,
    this.warningList,
    this.authentication,
  });

  CustomerProfileImage? customerProfileImage;
  bool? processResult;
  dynamic errorList;
  dynamic warningList;
  dynamic authentication;

  factory LevelOneKycResponseModel.fromJson(Map<String, dynamic> json) => LevelOneKycResponseModel(
        customerProfileImage: json["customer_Profile_Image"] == null
            ? null
            : CustomerProfileImage.fromJson(json["customer_Profile_Image"]),
        processResult: json["process_result"],
        errorList: json["error_list"],
        warningList: json["warning_list"],
        authentication: json["authentication"],
      );

  Map<String, dynamic> toJson() => {
        "customer_Profile_Image": customerProfileImage?.toJson(),
        "process_result": processResult,
        "error_list": errorList,
        "warning_list": warningList,
        "authentication": authentication,
      };
}

class CustomerProfileImage {
  CustomerProfileImage({
    this.imageSelfie,
    this.imageSignature,
    this.imageBirthCertificate,
    this.imageParentConsent,
    this.imageParentGovId,
  });

  String? imageSelfie;
  String? imageSignature;
  String? imageBirthCertificate;
  String? imageParentConsent;
  String? imageParentGovId;

  factory CustomerProfileImage.fromJson(Map<String, dynamic> json) => CustomerProfileImage(
        imageSelfie: json["image_selfie"],
        imageSignature: json["image_signature"],
        imageBirthCertificate: json["image_birth_certificate"],
        imageParentConsent: json["image_parent_consent"],
        imageParentGovId: json["image_parent_gov_id"],
      );

  Map<String, dynamic> toJson() => {
        "image_selfie": imageSelfie,
        "image_signature": imageSignature,
        "image_birth_certificate": imageBirthCertificate,
        "image_parent_consent": imageParentConsent,
        "image_parent_gov_id": imageParentGovId,
      };
}
