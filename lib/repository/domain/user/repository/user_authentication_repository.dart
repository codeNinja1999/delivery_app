import 'package:fresh_fold_delivery/repository/repository.dart';

abstract class UserAuthenticationRepository {
  void clearCredential();
  Future<Either<Exception, String?>> getUser();
  Future<UserAccessCredential?> userAccessCredential();
  Future<Either<Exception, String>> clearPersistUser();
  Future<Either<Exception, String>> persistUser(String username);
  Future<Either<Exception, UserAccessCredential>> refreshUserToken();
  Future<Either<Exception, UserAccessCredential>> authenticateUser(LoginInfo loginInfo);
}
