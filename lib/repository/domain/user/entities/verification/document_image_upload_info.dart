import 'dart:io';
import 'package:fresh_fold_delivery/repository/repository.dart';

class DocumentImageUploadInfo {
  final DocumentImageInfo? primary;
  final DocumentImageInfo? secondary;
  final DocumentImageInfo? additional;
  final File? selfie;
  final String? facialMatch;
  final String? ocrName;
  final String? ocrBirthDate;
  final UploadUserKycInfo? documentImageInfo;
  final AzureInfo? azureInfo;

  DocumentImageUploadInfo({
    this.primary,
    this.secondary,
    this.additional,
    this.selfie,
    this.facialMatch,
    this.ocrName,
    this.ocrBirthDate,
    this.documentImageInfo,
    this.azureInfo,
  });
}

class DocumentImageInfo {
  final Catalog? idType;
  final File? idFrontImage;
  final File? idBackImage;
  final File? idAdditionalImage;

  DocumentImageInfo({
    this.idType,
    this.idFrontImage,
    this.idBackImage,
    this.idAdditionalImage,
  });
}
