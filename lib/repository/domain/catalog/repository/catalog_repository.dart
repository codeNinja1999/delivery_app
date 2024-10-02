import 'package:fresh_fold_delivery/repository/repository.dart';

abstract class CatalogRepository {
  Future<Either<Exception, List<Location>>> fetchLocation();
  Future<Either<Exception, String>> deleteLocation(CatalogFilter filter);
  Future<Either<Exception, String>> updateLocation(CatalogFilter filter);
  Future<Either<Exception, String>> addLocation(CatalogFilter filter);
  Future<Either<Exception, String>> addServiceType(CatalogFilter filter);
  Future<Either<Exception, String>> deleteServiceType(CatalogFilter filter);
  Future<Either<Exception, String>> updateServiceType(CatalogFilter filter);
  Future<Either<Exception, List<ServiceType>>> fetchServiceType();
  // Future<Either<Exception, List<DepositType>>> fetchDepositType(CatalogFilter filter);
}
