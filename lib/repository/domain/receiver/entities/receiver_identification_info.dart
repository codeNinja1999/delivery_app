import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalogs.dart';

class ReceiverIdentificationInfo {
  final Catalog idType;
  final String? idNumber;
  final String? issuedDate;
  final String? expiryDate;
  final Catalog issuedCountry;
  final Catalog issuedCountryState;

  ReceiverIdentificationInfo(
      {required this.idType,
      this.idNumber,
      this.issuedDate,
      this.expiryDate,
      required this.issuedCountry,
      required this.issuedCountryState});
}
