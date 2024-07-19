import 'package:fresh_fold_delivery/repository/data/user/models/verification/upload_document_request_model.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/verification/document_image_upload_info.dart';

extension DocumentUploadRequestMapping on DocumentImageUploadInfo {
  UploadDocumentRequestModel toRequestData() {
    final data = UploadDocumentRequestModel(
      documentIdType1: primary?.idType?.id,
      selfie: selfie,
      documentFront1: primary?.idFrontImage,
      documentBack1: additional?.idFrontImage,
      documentSide1: secondary?.idFrontImage,
      documentIdType2: secondary?.idType?.id,
      documentFront2: null,
      documentBack2: secondary?.idBackImage,
      documentIdType3: additional?.idType?.id,
      documentFront3: null,
      documentBack3: additional?.idBackImage,
      facialMatch: facialMatch,
      ocrName: ocrName,
      ocrBirthDate: ocrBirthDate,
      idIssueDate1: documentImageInfo?.primaryDocumentInfo?.issueDate,
      idIssueDate2: documentImageInfo?.secondaryDocumentInfo?.issueDate,
      idIssueDate3: documentImageInfo?.additionalDocumentInfo?.issueDate,
      idExpiryDate1: documentImageInfo?.primaryDocumentInfo?.expiryDate,
      idExpiryDate2: documentImageInfo?.secondaryDocumentInfo?.expiryDate,
      idExpiryDate3: documentImageInfo?.additionalDocumentInfo?.expiryDate,
      idNumber1: documentImageInfo?.primaryDocumentInfo?.idNumber,
      idNumber2: documentImageInfo?.secondaryDocumentInfo?.idNumber,
      idNumber3: documentImageInfo?.additionalDocumentInfo?.idNumber,
      idIssueCountry1: documentImageInfo?.primaryDocumentInfo?.idIssuingCountry?.id,
      idIssueCountry2: documentImageInfo?.secondaryDocumentInfo?.idIssuingCountry?.id,
      idIssueCountry3: documentImageInfo?.additionalDocumentInfo?.idIssuingCountry?.id,
    );
    return data;
  }
}
