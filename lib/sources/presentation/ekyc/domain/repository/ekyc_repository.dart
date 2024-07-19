import 'package:fresh_fold_delivery/repository/repository.dart';

abstract class EkycRepository {
  Future<Either<Exception, String>> getZlozInitializationToken();
  Future<Either<Exception, String>> notifyScanCompletion();
}
