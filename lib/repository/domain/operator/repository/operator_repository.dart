import 'package:fresh_fold_delivery/repository/repository.dart';

import '../entities/operator_entities.dart';

abstract class OperatorRepository {
  Future<Either<Exception, String?>> addOperator(Operator operatorInfo);
  Future<Either<Exception, String?>> updateOperator(Operator operatorInfo);
  Future<Either<Exception, String?>> deleteOperator(String operatorId);
}
