import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/entities.dart';

abstract class UserVerificationRepository {
  Future<Either<Exception, String>> uploadDocumentImage(DocumentImageUploadInfo verificationInfo);
  Future<Either<Exception, String>> uploadDocument(DocumentUpload documentInfo);
  Future<Either<Exception, String>> uploadCustomerKyc(UploadUserKycInfo userKycInfo);
  Future<Either<Exception, AzureInfo>> getAzureInfo(String uploadType);
}
