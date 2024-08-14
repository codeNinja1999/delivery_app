import '../../../../domain/user/entities/authentication/login_info.dart';
import '../../models/user_authentication/user_authentication_request_model.dart';

extension UserAuthenticationRequestMapping on LoginInfo {
  UserAuthenticationRequestModel toUserAuthenticate() {
    return UserAuthenticationRequestModel(email: email, password: password);
  }
}
