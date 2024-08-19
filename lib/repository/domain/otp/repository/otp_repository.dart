import 'package:either_dart/either.dart';
import '../entities/entities.dart';

abstract class OTPRepository {
  Future<Either<Exception, String>> generateRegisterOTP(GenerateOTP data);
  Future<Either<Exception, String>> verifyRegisterOTP(VerifyOTP verifyInfo);
  Future<Either<Exception, String>> generateForgotPasswordOTP(GenerateOTP data);
  Future<Either<Exception, String>> verifyForgotPasswordOTP(VerifyOTP verifyInfo);
  Future<Either<Exception, String>> resendOTP(GenerateOTP data);
}
