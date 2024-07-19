import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalogs.dart';
import 'package:fresh_fold_delivery/repository/domain/common/model/name.dart';

class TransactionSenderResult {
  final Country? country;
  final Catalog? currency;
  final DepositType? depositMode;
  final String? realAmount;
  final String? deductedAmount;

  TransactionSenderResult({
    this.country,
    this.currency,
    this.depositMode,
    this.realAmount,
    this.deductedAmount,
  });
}

class DetailedTransactionSenderResult {
  final Name? name;
  final Country? country;
  final Catalog? currency;
  final DepositType? depositMode;
  final String? realAmount;
  final String? deductedAmount;

  DetailedTransactionSenderResult({
    this.name,
    this.country,
    this.currency,
    this.depositMode,
    this.realAmount,
    this.deductedAmount,
  });
}
