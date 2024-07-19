part of 'document_information_bloc.dart';

class DocumentInformationState extends Equatable {
  final String? idNumber;
  final String? idIssueDate;
  final String? idExpiryDate;
  final Country? idIssueCountry;
  final List<Country>? idIssueCountryList;
  final FormStatus status;

  String? get idNumberValidation => (idNumber != "") ? null : LocaleKeys.idNumberErrorMessage.value;
  String? get idIssueDateValidation => (idIssueDate != "") ? null : LocaleKeys.idIssueErrorMessage.value;
  String? get idExpiryDateValidation => (idExpiryDate != "") ? null : LocaleKeys.idExpiryErrorMessage.value;
  String? get idIssueCountryValidation => (idIssueCountry != null) ? null : LocaleKeys.idIssueCountryErrorMessage.value;

  UploadUserKycInfo get data => _makeData();

  DocumentInformationState({
    this.idNumber = "",
    this.idIssueDate = "",
    this.idExpiryDate = "",
    this.idIssueCountry,
    this.idIssueCountryList,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  DocumentInformationState copyWith({
    String? idNumber,
    String? idIssueDate,
    String? idExpiryDate,
    Country? idIssueCountry,
    List<Country>? idIssueCountryList,
    Catalog? idIssueJurisdiction,
    String? idIssueJurisdictionOther,
    List<Catalog>? idIssueJurisdictionList,
    FormStatus? status,
  }) {
    return DocumentInformationState(
      idNumber: idNumber ?? this.idNumber,
      idIssueDate: idIssueDate ?? this.idIssueDate,
      idExpiryDate: idExpiryDate ?? this.idExpiryDate,
      idIssueCountry: idIssueCountry ?? this.idIssueCountry,
      idIssueCountryList: idIssueCountryList ?? this.idIssueCountryList,
      status: status ?? InitialStatus(),
    );
  }

  UploadUserKycInfo _makeData() {
    return UploadUserKycInfo(
      documentIdNumber: idNumber,
      idExpiryDate: idExpiryDate,
      idIssueDate: idIssueDate,
      issuedCountry: idIssueCountry,
    );
  }

  @override
  List<Object?> get props => [
        idNumber,
        idIssueDate,
        idExpiryDate,
        idIssueCountry,
        idIssueCountryList,
        status,
      ];
}
