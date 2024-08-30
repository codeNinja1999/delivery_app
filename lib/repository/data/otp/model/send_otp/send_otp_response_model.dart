
import '../../../common/model/role.dart';

class SendOtpResponseModel {
  final User? user;
  final String? token;

  SendOtpResponseModel({this.user, this.token});

  factory SendOtpResponseModel.fromJson(Map<String, dynamic> json) => SendOtpResponseModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );
}

class User {
  final int? userId;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final dynamic userName;
  final String? email;
  final List<Role>? roles;
  final String? phoneCode;
  final String? phoneNumber;
  final bool? otpVerified;
  final bool? isVerified;
  final String? verifiedDate;
  final dynamic userAddress;
  final bool? isGuest;

  User({
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

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        userName: json["user_name"],
        email: json["email"],
        roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
        phoneCode: json["phone_code"],
        phoneNumber: json["phone_number"],
        otpVerified: json["otp_verified"],
        isVerified: json["is_verified"],
        verifiedDate: json["verified_date"],
        userAddress: json["user_address"],
        isGuest: json["is_guest"],
      );
}
