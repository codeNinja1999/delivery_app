import 'package:fresh_fold_delivery/repository/repository.dart';

abstract class UserRegistrationRepository {
  Future<Either<Exception, bool?>> register(UserRegistrationInfo data);
  Future<Either<Exception, LevelOneKycDocument>> uploadLevelOneKycDocument(
      UploadLevelOneKycDocumentInfo userlevelOneKycInfo);
}
