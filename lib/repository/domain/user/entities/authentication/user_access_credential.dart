import '../../../../data/common/model/role.dart';
import '../user_info/user_contact_info.dart';

class UserAccessCredential {
  final String? clientId;
  final String? username;
  final bool? firstTimeLogin;
  final String? lastLoginTs;
  final String accessToken;
  final String? tokenType;
  final int? expiresIn;
  final String? refreshToken;
  final String? expires;
  final String? issued;
  final int? userId;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? userName;
  final String? email;
  final List<Role>? roles;
  final String? phoneCode;
  final String? phoneNumber;
  final bool? otpVerified;
  final bool? isVerified;
  final String? verifiedDate;
  final UserContactInfo? userAddress;
  final bool? isGuest;

  UserAccessCredential({
    this.clientId,
    this.username,
    this.firstTimeLogin,
    this.lastLoginTs,
    required this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.refreshToken,
    this.expires,
    this.issued,
    this.userId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.userName,
    this.email,
    this.roles,
    this.phoneCode,
    this.phoneNumber,
    this.otpVerified,
    this.isVerified,
    this.verifiedDate,
    this.userAddress,
    this.isGuest,
  });
}
