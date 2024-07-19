import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalogs.dart';

class ReceiverPayoutInfo {
  final Catalog? country;
  final Catalog? nationality;
  final Catalog? payoutPartner;
  final PaymentMode? mode;
  final Catalog? currency;
  final Catalog? headOffice;
  final Branch? branch;
  final Catalog? accountType;
  final Bank? bank;
  final String? accountNumber;

  ReceiverPayoutInfo({
    this.country,
    this.nationality,
    this.payoutPartner,
    required this.mode,
    this.currency,
    this.headOffice,
    this.branch,
    this.accountType,
    required this.bank,
    this.accountNumber,
  });
}

class DetailedReceiverPayoutInfo {
  final String? id;
  final ReceivingCountry? receivingCountry;
  final Catalog? nationality;
  final Catalog? payoutPartner;
  final PaymentMode? mode;
  final Catalog? currency;
  final Catalog? headOffice;
  final Branch? branch;
  final Catalog? accountType;
  final Bank? bank;
  final String? accountNumber;

  DetailedReceiverPayoutInfo({
    this.id,
    this.receivingCountry,
    this.nationality,
    this.payoutPartner,
    this.mode,
    this.currency,
    this.headOffice,
    this.branch,
    this.accountType,
    this.bank,
    this.accountNumber,
  });
}
