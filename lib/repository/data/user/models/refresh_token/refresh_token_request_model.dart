class RefreshTokenRequestModel {
  final String? refreshToken;
  final String? accessToken;
  final String? grantType;

  RefreshTokenRequestModel({this.refreshToken, this.accessToken, this.grantType});

  Map<String, dynamic> toJson() => {"refresh_token": refreshToken, "access_token": accessToken, "grant_type": grantType};
}
