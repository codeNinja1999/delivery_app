import 'package:fresh_fold_delivery/repository/repository.dart';

import '../entities/operator_entities.dart';

abstract class OperatorRepository {
  Future<Either<Exception, String?>> addOperator(OperatorInfo operatorInfo);
  Future<Either<Exception, String?>> updateOperator(OperatorInfo operatorInfo);
  Future<Either<Exception, String?>> deleteOperator(String operatorId);
}
