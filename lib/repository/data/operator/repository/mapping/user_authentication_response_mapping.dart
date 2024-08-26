import 'package:fresh_fold_delivery/repository/data/user/models/user_authentication/user_authentication_response_model.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/authentication/user_access_credential.dart';

extension UserAuthenticationResponseMapping on UserAuthenticationResponseModel {
  UserAccessCredential toDomain() {
    return UserAccessCredential(
      accessToken: accessToken ?? "",
      refreshToken: refreshToken ?? "",
      firstTimeLogin: firstTimeLogin,
      lastLoginTs: lastLoginTs,
    );
  }
}
