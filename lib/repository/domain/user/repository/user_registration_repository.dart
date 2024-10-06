import 'package:fresh_fold_delivery/repository/domain/user/entities/registration/operator_registration_info.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

abstract class UserRegistrationRepository {
  Future<Either<Exception, String?>> register(RegistrationInfo registrationInfo);
  Future<Either<Exception, String?>> registerOperator(OperatorRegistrationInfo registrationInfo);
}
