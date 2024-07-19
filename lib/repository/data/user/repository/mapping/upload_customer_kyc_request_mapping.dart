import 'package:fresh_fold_delivery/repository/data/user/models/customer_kyc/upload_customer_kyc_request_model.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/verification/upload_user_kyc_info.dart';

extension UploadCustomerKycRequestMapping on UploadUserKycInfo {
  UploadCustomerKycRequestModel toRequestData() {
    final data = UploadCustomerKycRequestModel(
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      documentIdNumber: documentIdNumber,
      dateOfBirth: dateOfBirth,
      documentIdType: documentIdType?.value,
      nationality: nationality?.id,
      state: state?.value,
      address: streetAddress,
      address2: streetAddress,
      senderZipCode: zipCode,
      idIssueDate: idIssueDate,
      idExpiryDate: idExpiryDate,
      issueCountry: issuedCountry?.id,
      city: city,
      gender: gender?.id,
      occupation: occupation?.id,
      visaType: idVisaType?.id,
      selfieWithIdImage: selfieWithImageId,
      idIssueJurisdiction: idIssueJurisdiction?.id,
      japaneseStreetAddress: japaneseStreetAddress,
      japaneseSenderAddress: japaneseSenderAddress,
      idIssueJurisdictionOther: idIssueJurisdictionOther,
      frontImageName: frontImageName,
      backImageName: backImageName,
      additionalImageName: additionalImageName,
    );
    return data;
  }
}
