import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalogs.dart';

class TransactionSenderInfo {
  final Country? country;
  final Catalog? currency;
  final DepositType? depositMode;

  TransactionSenderInfo({this.country, this.currency, this.depositMode});
}
