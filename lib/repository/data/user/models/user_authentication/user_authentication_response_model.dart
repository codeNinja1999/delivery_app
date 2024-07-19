class UserAuthenticationResponseModel {
  UserAuthenticationResponseModel({
    this.code,
    this.username,
    this.firstTimeLogin,
    this.lastLoginTs,
    this.accessToken,
    this.refreshToken,
    this.country,
    this.currency,
    this.newDeviceFlag,
    this.deviceVerificationProcessId,
  });

  final String? code;
  final String? username;
  final bool? firstTimeLogin;
  final String? lastLoginTs;
  final String? accessToken;
  final String? refreshToken;
  final String? country;
  final String? currency;
  final bool? newDeviceFlag;
  final String? deviceVerificationProcessId;

  factory UserAuthenticationResponseModel.fromJson(Map<String, dynamic> json) => UserAuthenticationResponseModel(
        code: json["code"],
        username: json["username"],
        firstTimeLogin: json["first_time_login"],
        lastLoginTs: json["last_login_ts"],
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
        country: json["country"],
        currency: json["currency"],
        newDeviceFlag: json["new_device_flag"],
        deviceVerificationProcessId: json["new_device_process_id"],
      );
}
