part of 'kyc_verification_bloc.dart';

class KycVerificationState extends Equatable {
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final Country? nationality;
  final String? dateOfBirth;
  final Catalog? state;
  final String? streetAddress;
  final String? japaneseStreetAddress;
  final String? japaneseSenderAddress;
  final String? zipCode;
  final String? city;
  final Catalog? occupation;
  final Catalog? gender;
  final Catalog? visaType;
  final Catalog? documentType;
  final Catalog? primarySelectedIDType;
  final Catalog? secondarySelectedIDType;
  final Catalog? additionalSelectedIDType;
  final File? primaryImage;
  final File? secondaryImage;
  final File? additionalImage;
  final File? selfieImage;
  final String? primaryImageName;
  final String? secondaryImageName;
  final String? additionalImageName;
  final String? selfieImageName;
  final String? error;
  final bool isClearSelfie;
  final bool isClearSecondaryDoc;
  final bool isClearPrimaryDoc;
  final bool isClearAdditionalDoc;
  final String? idNumber;
  final String? idIssueDate;
  final String? idExpiryDate;
  final Country? idIssueCountry;
  final bool isKycDone;
  final AzureInfo? azureInfo;
  final FormStatus status;

  KycVerificationState({
    this.firstName,
    this.middleName,
    this.lastName,
    this.nationality,
    this.dateOfBirth,
    this.state,
    this.visaType,
    this.city,
    this.japaneseStreetAddress,
    this.japaneseSenderAddress,
    this.zipCode,
    this.streetAddress,
    this.occupation,
    this.gender,
    this.primaryImageName,
    this.secondaryImageName,
    this.additionalImageName,
    this.selfieImageName,
    this.documentType,
    this.primarySelectedIDType,
    this.secondarySelectedIDType,
    this.additionalSelectedIDType,
    this.primaryImage,
    this.secondaryImage,
    this.idNumber,
    this.idIssueDate,
    this.idExpiryDate,
    this.idIssueCountry,
    this.additionalImage,
    this.selfieImage,
    this.isKycDone = false,
    this.isClearSelfie = false,
    this.isClearSecondaryDoc = false,
    this.isClearPrimaryDoc = false,
    this.isClearAdditionalDoc = false,
    this.azureInfo,
    this.error,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  KycVerificationState copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    Country? nationality,
    String? dateOfBirth,
    Catalog? state,
    String? streetAddress,
    String? zipCode,
    String? city,
    Catalog? occupation,
    Catalog? visaType,
    String? japaneseStreetAddress,
    String? japaneseSenderAddress,
    Catalog? gender,
    Catalog? documentType,
    Catalog? primarySelectedIDType,
    Catalog? secondarySelectedIDType,
    Catalog? additionalSelectedIDType,
    File? primaryImage,
    File? secondaryImage,
    File? additionalImage,
    File? selfieImage,
    String? primaryImageName,
    String? secondaryImageName,
    String? additionalImageName,
    String? selfieImageName,
    String? idNumber,
    String? idIssueDate,
    String? idExpiryDate,
    Country? idIssueCountry,
    bool? isKycDone,
    bool? isClearSelfie,
    bool? isClearSecondaryDoc,
    bool? isClearPrimaryDoc,
    bool? isClearAdditionalDoc,
    String? error,
    AzureInfo? azureInfo,
    FormStatus? status,
  }) {
    return KycVerificationState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      nationality: nationality ?? this.nationality,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      state: state ?? this.state,
      city: city ?? this.city,
      zipCode: zipCode ?? this.zipCode,
      visaType: visaType ?? this.visaType,
      streetAddress: streetAddress ?? this.streetAddress,
      japaneseStreetAddress: japaneseStreetAddress ?? this.japaneseStreetAddress,
      japaneseSenderAddress: japaneseSenderAddress ?? this.japaneseSenderAddress,
      occupation: occupation ?? this.occupation,
      gender: gender ?? this.gender,
      idNumber: idNumber ?? this.idNumber,
      idIssueDate: idIssueDate ?? this.idIssueDate,
      idExpiryDate: idExpiryDate ?? this.idExpiryDate,
      idIssueCountry: idIssueCountry ?? this.idIssueCountry,
      documentType: documentType ?? this.documentType,
      primarySelectedIDType: primarySelectedIDType ?? this.primarySelectedIDType,
      secondarySelectedIDType: secondarySelectedIDType ?? this.secondarySelectedIDType,
      additionalSelectedIDType: additionalSelectedIDType ?? this.additionalSelectedIDType,
      primaryImage: isClearPrimaryDoc == true ? null : primaryImage ?? this.primaryImage,
      secondaryImage: isClearSecondaryDoc == true ? null : secondaryImage ?? this.secondaryImage,
      additionalImage: isClearAdditionalDoc == true ? null : additionalImage ?? this.additionalImage,
      selfieImage: isClearSelfie == true ? null : selfieImage ?? this.selfieImage,
      primaryImageName: primaryImageName ?? this.primaryImageName,
      secondaryImageName: secondaryImageName ?? this.secondaryImageName,
      additionalImageName: additionalImageName ?? this.additionalImageName,
      selfieImageName: selfieImageName ?? this.selfieImageName,
      isKycDone: isKycDone ?? this.isKycDone,
      error: error,
      azureInfo: azureInfo ?? this.azureInfo,
      status: status ?? this.status,
    );
  }

  UploadUserKycInfo data(String? selfieName) => _makeData(selfieName);

  UploadUserKycInfo _makeData(String? selfieName) {
    return UploadUserKycInfo(
      documentIdType: documentType,
      nationality: nationality,
      dateOfBirth: dateOfBirth,
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      state: state,
      streetAddress: streetAddress,
      zipCode: zipCode,
      city: city,
      gender: gender,
      occupation: occupation,
      issuedCountry: idIssueCountry,
      idIssueDate: idIssueDate,
      idExpiryDate: idExpiryDate,
      documentIdNumber: idNumber,
      frontImageName: primaryImageName,
      backImageName: secondaryImageName,
      additionalImageName: additionalImageName,
      selfieWithImageId: (selfieImageName != null) ? selfieImageName : selfieName,
    );
  }

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        middleName,
        nationality,
        dateOfBirth,
        visaType,
        state,
        city,
        zipCode,
        occupation,
        gender,
        streetAddress,
        azureInfo,
        japaneseSenderAddress,
        documentType,
        idNumber,
        idIssueDate,
        idExpiryDate,
        idIssueCountry,
        primarySelectedIDType,
        secondarySelectedIDType,
        additionalSelectedIDType,
        primaryImage,
        secondaryImage,
        additionalImage,
        selfieImage,
        primaryImageName,
        secondaryImageName,
        additionalImageName,
        selfieImageName,
        isKycDone,
        error,
        isClearSelfie,
        isClearSecondaryDoc,
        isClearPrimaryDoc,
        isClearAdditionalDoc,
        status,
      ];
}
