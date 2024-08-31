class UserAuthenticationRequestModel {
  final String? email;
  final String? password;
  final String? role;

  UserAuthenticationRequestModel({this.email, this.password, this.role});

  Map<String, dynamic> toJson() => {"email": email, "password": password, "role": role};
}
