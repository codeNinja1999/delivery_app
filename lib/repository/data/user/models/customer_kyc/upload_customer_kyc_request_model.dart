class UploadCustomerKycRequestModel {
  String? firstName;
  String? middleName;
  String? lastName;
  String? documentIdType;
  String? documentIdNumber;
  String? gender;
  String? dateOfBirth;
  String? idExpiryDate;
  String? issueCountry;
  String? issueState;
  String? idIssueDate;
  String? facialMatchPercentage;
  String? nationality;
  String? address;
  String? address2;
  String? japaneseStreetAddress;
  String? japaneseSenderAddress;
  dynamic occupation;
  dynamic senderOccupationOther;
  dynamic sourceOfFunds;
  dynamic sourceOfFundsOther;
  String? state;
  String? city;
  String? senderZipCode;
  String? selfieWithIdImage;
  String? idImage;
  String? visaType;
  String? idIssueJurisdiction;
  String? frontImageName;
  String? backImageName;
  String? additionalImageName;
  String? idIssueJurisdictionOther;

  UploadCustomerKycRequestModel({
    this.firstName,
    this.middleName,
    this.lastName,
    this.documentIdType,
    this.documentIdNumber,
    this.gender,
    this.dateOfBirth,
    this.idExpiryDate,
    this.issueCountry,
    this.issueState,
    this.idIssueDate,
    this.facialMatchPercentage,
    this.nationality,
    this.address,
    this.address2,
    this.occupation,
    this.senderOccupationOther,
    this.sourceOfFunds,
    this.sourceOfFundsOther,
    this.japaneseStreetAddress,
    this.japaneseSenderAddress,
    this.state,
    this.city,
    this.senderZipCode,
    this.selfieWithIdImage,
    this.idImage,
    this.idIssueJurisdiction,
    this.idIssueJurisdictionOther,
    this.visaType,
    this.frontImageName,
    this.backImageName,
    this.additionalImageName,
  });

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "document_id_type": documentIdType,
        "document_id_number": documentIdNumber,
        "gender": gender,
        "date_of_birth": dateOfBirth,
        "id_expiry_date": idExpiryDate,
        "issueCountry": issueCountry,
        "issueState": issueState,
        "id_issue_date": idIssueDate,
        "facial_match_percentage": facialMatchPercentage,
        "nationality": nationality,
        "address": address,
        "address2": address2,
        "ocupation": occupation,
        "sender_occupation_other": senderOccupationOther,
        "source_of_funds": sourceOfFunds,
        "source_of_funds_other": sourceOfFundsOther,
        "state": state,
        "city": city,
        "sender_zip_code": senderZipCode,
        "selfie_with_id_image": selfieWithIdImage,
        "id_image": idImage,
        "ID_Issuing_Jurisdiction": idIssueJurisdiction,
        "ID_Issuing_Jurisdiction_Others": idIssueJurisdictionOther,
        "Customer_visa_Type": visaType,
        "street_address_jp": japaneseStreetAddress,
        "sender_address_jp": japaneseSenderAddress,
        "front_image_name": frontImageName,
        "back_image_name": backImageName,
        "additional_image_name": additionalImageName,
      };
}
