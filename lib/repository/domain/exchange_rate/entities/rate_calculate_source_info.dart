import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalogs.dart';

class RateCalculateSourceInfo {
  final Country country;
  final Catalog currency;
  final Catalog? depositMode;

  RateCalculateSourceInfo({required this.country, required this.currency, this.depositMode});
}
