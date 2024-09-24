import '../../../common/model/role.dart';

class GetUserInfoResponseModel {
  int? userId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? userName;
  String? email;
  List<Role>? roles;
  String? phoneCode;
  String? phoneNumber;
  bool? otpVerified;
  bool? isVerified;
  String? verifiedDate;
  UserAddress? userAddress;
  bool? isGuest;

  GetUserInfoResponseModel({
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

  factory GetUserInfoResponseModel.fromJson(Map<String, dynamic> json) => GetUserInfoResponseModel(
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
        userAddress: json["user_address"] == null ? null : UserAddress.fromJson(json["user_address"]),
        isGuest: json["is_guest"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "user_name": userName,
        "email": email,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x.toJson())),
        "phone_code": phoneCode,
        "phone_number": phoneNumber,
        "otp_verified": otpVerified,
        "is_verified": isVerified,
        "verified_date": verifiedDate,
        "user_address": userAddress?.toJson(),
        "is_guest": isGuest,
      };
}

class UserAddress {
  int? id;
  String? locationId;
  String? houseNumber;
  String? latitude;
  String? longitude;
  DateTime? createdAt;
  String? location;

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

  Map<String, dynamic> toJson() => {
        "id": id,
        "location_id": locationId,
        "house_number": houseNumber,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt?.toIso8601String(),
        "location": location,
      };
}
