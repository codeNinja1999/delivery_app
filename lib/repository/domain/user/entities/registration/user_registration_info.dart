import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalogs.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/authentication/login_info.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/registration/level_one_kyc_document.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user.dart';

class UserRegistrationInfo {
  final String processID;
  final bool? autoLogin;
  final String? language;
  final String? agentID;
  final String? campaignCode;
  final String? referralCode;
  final String? customerInviteCode;
  final Catalog? country;
  final LoginInfo loginInfo;
  final User userInfo;
  final LevelOneKycDocument? levelOneKyc;

  UserRegistrationInfo({
    required this.processID,
    this.autoLogin,
    this.language,
    this.agentID,
    this.campaignCode,
    this.country,
    this.referralCode,
    this.customerInviteCode,
    required this.loginInfo,
    required this.userInfo,
    this.levelOneKyc,
  });
}
