class ChangePasswordRequestModel {
  final String? currentPassword;
  final String? password;
  final String? confirmPassword;

  ChangePasswordRequestModel({this.currentPassword, this.password, this.confirmPassword});

  Map<String, dynamic> toJson() => {
        "current_password": currentPassword,
        "password": password,
        "confirm_password": confirmPassword,
      };
}
