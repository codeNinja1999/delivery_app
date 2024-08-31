import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/domain/account_utility/account_utility.dart';

abstract class PasswordRepository {
  Future<Either<Exception, String>> changePassword(ChangePasswordInfo data);
  Future<Either<Exception, String>> resetPassword(ResetPasswordInfo data);
}
