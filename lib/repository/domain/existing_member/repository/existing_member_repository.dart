import 'package:either_dart/either.dart';

import '../entities/entities.dart';

abstract class ExistingMemberRepository {
  Future<Either<Exception, CheckExistingMemberResult>> checkExistingMember(CheckExistingMemberInfo info);
  Future<Either<Exception, String>> updateExistingMember(UpdateExistingMemberInfo info);
}
