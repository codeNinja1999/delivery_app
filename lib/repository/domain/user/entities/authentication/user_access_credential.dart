class UserAccessCredential {
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

  UserAccessCredential(
      {this.clientId,
      this.username,
      this.firstTimeLogin,
      this.lastLoginTs,
      required this.accessToken,
      this.tokenType,
      this.expiresIn,
      required this.refreshToken,
      this.expires,
      this.issued});
}
