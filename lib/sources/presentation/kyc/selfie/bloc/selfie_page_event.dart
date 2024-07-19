part of 'selfie_page_bloc.dart';

abstract class SelfiePageEvent {}

class UploadImages extends SelfiePageEvent {
  //final UploadUserKycInfo uploadUserKycInfo;
  final File? primaryImage;
  final File? secondaryImage;
  final File? additionalImage;
  final File? selfieImage;
  final Catalog? idType;

  UploadImages({
    //required this.uploadUserKycInfo,
    this.primaryImage,
    this.secondaryImage,
    this.additionalImage,
    this.selfieImage,
    this.idType,
  });
}

class UploadKyc extends SelfiePageEvent {
  final UploadUserKycInfo ? uploadUserKycInfo;
  UploadKyc(this.uploadUserKycInfo);
}

class UploadSelfieDocument extends SelfiePageEvent {
  final AzureInfo? azureInfo;
  final File? selfieImage;

  UploadSelfieDocument(this.azureInfo, this.selfieImage);
}




