import 'package:fresh_fold_delivery/repository/domain/user/entities/authentication/login_type.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/authentication/third_party_credential.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/authentication/user_login_credential.dart';

class LoginInfo {
  final UserLoginCredential? userLoginCredential;
  final ThirdPartyCredential? thirdPartyCredential;
  final LoginType loginType;

  LoginInfo({this.userLoginCredential, this.thirdPartyCredential, required this.loginType});
}
