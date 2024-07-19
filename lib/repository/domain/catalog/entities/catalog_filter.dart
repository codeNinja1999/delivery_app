import 'package:fresh_fold_delivery/repository/repository.dart';

class CatalogFilter {
  final String language;
  final String? countryCode;
  final String? receivingCountry;
  final String? receiverType;
  final PaymentMode? paymentMode;
  final String? postalCode;
  final Catalog? state;
  final String? bankId;

  CatalogFilter({
    required this.language,
    this.countryCode,
    this.receivingCountry,
    this.receiverType,
    this.paymentMode,
    this.postalCode,
    this.state,
    this.bankId,
  });
}
