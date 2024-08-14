class UserAuthenticationRequestModel {
  final String? email;
  final String? password;

  UserAuthenticationRequestModel({this.email, this.password});

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}
