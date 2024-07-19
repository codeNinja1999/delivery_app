import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalogs.dart';

class UserIdentificationInfo {
  final Catalog? idType;
  final String? idNumber;
  final String? issuedDate;
  final String? expiryDate;
  final Catalog? issuedCountry;
  final Catalog? idIssueJurisdiction;
  final String? idIssueJurisdictionOther;
  final Catalog? issuedCountryState;
  final String? referenceNumber;
  final String? nameAsCard;
  final String? cardColor;

  UserIdentificationInfo({
    this.idType,
    this.idNumber,
    this.issuedDate,
    this.expiryDate,
    this.issuedCountry,
    this.idIssueJurisdiction,
    this.idIssueJurisdictionOther,
    this.issuedCountryState,
    this.referenceNumber,
    this.nameAsCard,
    this.cardColor,
  });
}
