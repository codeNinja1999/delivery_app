import 'package:fresh_fold_delivery/repository/repository.dart';

abstract class UserRegistrationRepository {
  Future<Either<Exception, String?>> register();
}
