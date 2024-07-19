import 'dart:io';

class UploadDocumentRequestModel {
  final File? selfie;
  final String? documentIdType1;
  final File? documentFront1;
  final File? documentBack1;
  final String? documentIdType2;
  final File? documentFront2;
  final File? documentBack2;
  final String? documentIdType3;
  final File? documentFront3;
  final File? documentBack3;
  final File? documentSide1;
  final String? facialMatch;
  final String? ocrName;
  final String? ocrBirthDate;
  final String? idNumber1;
  final String? idNumber2;
  final String? idNumber3;
  final String? idExpiryDate1;
  final String? idExpiryDate2;
  final String? idExpiryDate3;
  final String? idIssueDate1;
  final String? idIssueDate2;
  final String? idIssueDate3;
  final String? idIssueCountry1;
  final String? idIssueCountry2;
  final String? idIssueCountry3;

  UploadDocumentRequestModel({
    this.selfie,
    this.documentIdType1,
    this.documentFront1,
    this.documentBack1,
    this.documentSide1,
    this.documentIdType2,
    this.documentFront2,
    this.documentBack2,
    this.documentIdType3,
    this.documentFront3,
    this.documentBack3,
    this.facialMatch,
    this.ocrName,
    this.ocrBirthDate,
    this.idNumber1,
    this.idNumber2,
    this.idNumber3,
    this.idExpiryDate1,
    this.idExpiryDate2,
    this.idExpiryDate3,
    this.idIssueDate1,
    this.idIssueDate2,
    this.idIssueDate3,
    this.idIssueCountry1,
    this.idIssueCountry2,
    this.idIssueCountry3,
  });

  Map<String, dynamic> toJson() => {
        "selfie": selfie,
        "document_id_type1": documentIdType1,
        "document_front1": documentFront1,
        "document_back1": documentBack1,
        "document_side1": documentSide1,
        "document_id_type2": documentIdType2,
        "document_front2": documentFront2,
        "document_back2": documentBack2,
        "document_id_type3": documentIdType3,
        "document_front3": documentFront3,
        "document_back3": documentBack3,
        "facial_match": facialMatch,
        "ocr_name": ocrName,
        "ocr_birthdate": ocrBirthDate,
        "id_issue_date1": idIssueDate1,
        "id_issue_date2": idIssueDate2,
        "id_issue_date3": idIssueDate3,
        "id_number1": idNumber1,
        "id_number2": idNumber2,
        "id_number3": idNumber3,
        "id_expiry_date1": idExpiryDate1,
        "id_expiry_date2": idExpiryDate2,
        "id_expiry_date3": idExpiryDate3,
        "id_issue_country1": idIssueCountry1,
        "id_issue_country2": idIssueCountry2,
        "id_issue_country3": idIssueCountry3,
      };
}
