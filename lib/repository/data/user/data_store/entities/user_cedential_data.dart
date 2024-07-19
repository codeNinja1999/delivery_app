import 'package:fresh_fold_delivery/repository/domain/user/entities/authentication/user_access_credential.dart';

class UserCredentialData {
  final String? clientId;
  final String? username;
  final bool? firstTimeLogin;
  final String? lastLoginTs;
  final String accessToken;
  final String? tokenType;
  final int? expiresIn;
  final String refreshToken;
  final String? expires;
  final String? issued;

  UserCredentialData(
      {required this.clientId,
      required this.username,
      required this.firstTimeLogin,
      required this.lastLoginTs,
      required this.accessToken,
      required this.tokenType,
      required this.expiresIn,
      required this.refreshToken,
      required this.expires,
      required this.issued});

  UserCredentialData.fromCredential({required UserAccessCredential data})
      : clientId = data.clientId,
        accessToken = data.accessToken,
        username = data.username,
        firstTimeLogin = data.firstTimeLogin,
        lastLoginTs = data.lastLoginTs,
        tokenType = data.tokenType,
        expiresIn = data.expiresIn,
        refreshToken = data.refreshToken,
        expires = data.expires,
        issued = data.issued;

  factory UserCredentialData.fromJson(Map<String, dynamic> json) => UserCredentialData(
      clientId: json["clientId"],
      username: json["username"],
      firstTimeLogin: json["firstTimeLogin"],
      lastLoginTs: json["lastLoginTs"],
      accessToken: json["accessToken"],
      tokenType: json["tokenType"],
      expiresIn: json["expiresIn"],
      refreshToken: json["refreshToken"],
      expires: json["expires"],
      issued: json["issued"]);

  Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "username": username,
        "firstTimeLogin": firstTimeLogin,
        "lastLoginTs": lastLoginTs,
        "accessToken": accessToken,
        "tokenType": tokenType,
        "expiresIn": expiresIn,
        "refreshToken": refreshToken,
        "expires": expires,
        "issued": issued,
      };
}
