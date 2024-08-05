import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/entities.dart';

abstract class UserVerificationRepository {
  Future<Either<Exception, String>> uploadDocumentImage(DocumentImageUploadInfo verificationInfo);
}
