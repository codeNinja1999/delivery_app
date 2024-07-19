class UserAuthenticationRequestModel {
  UserAuthenticationRequestModel({
    this.username,
    this.password,
    this.grantType,
    this.fcmToken,
  });

  String? username;
  String? password;
  String? grantType;
  String? fcmToken;

  Map<String, dynamic> toJson() =>
      {"username": username, "password": password, "grant_type": grantType, "fcm_registration_id": fcmToken};
}
