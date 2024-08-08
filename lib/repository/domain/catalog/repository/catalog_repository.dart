import 'package:fresh_fold_delivery/repository/repository.dart';

abstract class CatalogRepository {
  Future<Either<Exception, List<Location>>> fetchLocation(CatalogFilter filter);
  Future<Either<Exception, List<ServiceType>>> fetchServiceType(CatalogFilter filter);
  Future<Either<Exception, List<DepositType>>> fetchDepositType(CatalogFilter filter);
}
