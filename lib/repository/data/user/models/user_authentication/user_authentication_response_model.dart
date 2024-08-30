import '../../../common/model/role.dart';

class UserAuthenticationResponseModel {
  final User? user;
  final String? token;

  UserAuthenticationResponseModel({
    this.user,
    this.token,
  });

  factory UserAuthenticationResponseModel.fromJson(Map<String, dynamic> json) => UserAuthenticationResponseModel(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        token: json["token"],
      );
}

class User {
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
  final UserAddress? userAddress;
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
        roles: json["roles"] == null ? [] : List<Role>.from(json["roles"]?.map((x) => Role.fromJson(x))),
        phoneCode: json["phone_code"],
        phoneNumber: json["phone_number"],
        otpVerified: json["otp_verified"],
        isVerified: json["is_verified"],
        verifiedDate: json["verified_date"],
        userAddress: json["user_address"] == null ? null : UserAddress.fromJson(json["user_address"]),
        isGuest: json["is_guest"],
      );
}

class UserAddress {
  final int? id;
  final String? locationId;
  final String? houseNumber;
  final String? latitude;
  final String? longitude;
  final DateTime? createdAt;
  final String? location;

  UserAddress({
    this.id,
    this.locationId,
    this.houseNumber,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.location,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
        id: json["id"],
        locationId: json["location_id"],
        houseNumber: json["house_number"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        location: json["location"],
      );
}
