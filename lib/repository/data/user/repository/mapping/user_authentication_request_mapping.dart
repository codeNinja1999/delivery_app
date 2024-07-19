import 'package:fresh_fold_delivery/repository/data/user/models/user_authentication/user_authentication_request_model.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/authentication/login_info.dart';

extension UserAuthenticationRequestMapping on LoginInfo {
  UserAuthenticationRequestModel toRequestData() {
    return UserAuthenticationRequestModel(
      username: userLoginCredential?.username ?? "",
      password: userLoginCredential?.password ?? "",
      grantType: "password",
      fcmToken: thirdPartyCredential?.fcmToken,
    );
  }
}
