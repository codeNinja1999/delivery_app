import 'package:either_dart/either.dart';

import 'package:fresh_fold_delivery/repository/domain/app_authentication/entities/app_credential.dart';
import 'package:fresh_fold_delivery/repository/domain/app_authentication/entities/app_info.dart';

abstract class AppAuthenticationRepository {
  Future<Either<Exception, AppAccessCredential>> generateKey(AppInfo appInfo, String appKey);
  Future<Either<Exception, String>> setAppLaunchStatus();
}
