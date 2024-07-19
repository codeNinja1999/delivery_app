import 'package:either_dart/either.dart';
import '../entities/entities.dart';

abstract class OTPRepository {
  Future<Either<Exception, String>> generateOTP(GenerateOTP data);
  Future<Either<Exception, OTPAccessCredential>> verifyOTP(VerifyOTP verifyInfo);
}
