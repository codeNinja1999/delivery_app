import 'package:fresh_fold_delivery/repository/domain/user/entities/authentication/user_access_credential.dart';

class UserCredentialData {
  final String? clientId;
  final bool? firstTimeLogin;
  final String? lastLoginTs;
  final String accessToken;
  final String? tokenType;
  final int? expiresIn;
  final String? refreshToken;
  final String? expires;
  final String? issued;

  final int? userId;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? userName;
  final String? email;
  final String? phoneCode;
  final String? phoneNumber;
  final bool? otpVerified;
  final bool? isVerified;
  final String? verifiedDate;
  final bool? isGuest;

  UserCredentialData({
    this.clientId,
    this.firstTimeLogin,
    this.lastLoginTs,
    required this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.refreshToken,
    this.expires,
    this.issued,
    this.userId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.userName,
    this.email,
    this.phoneCode,
    this.phoneNumber,
    this.otpVerified,
    this.isVerified,
    this.verifiedDate,
    this.isGuest,
  });

  UserCredentialData.fromCredential({required UserAccessCredential data})
      : clientId = data.clientId,
        accessToken = data.accessToken,
        userName = data.userName,
        firstTimeLogin = data.firstTimeLogin,
        lastLoginTs = data.lastLoginTs,
        tokenType = data.tokenType,
        expiresIn = data.expiresIn,
        refreshToken = data.refreshToken,
        expires = data.expires,
        issued = data.issued,
        userId = data.userId,
        email = data.email,
        firstName = data.firstName,
        middleName = data.middleName,
        lastName = data.lastName,
        phoneCode = data.phoneCode,
        phoneNumber = data.phoneNumber,
        isVerified = data.isVerified,
        verifiedDate = data.verifiedDate,
        otpVerified = data.otpVerified,
        isGuest = data.isGuest;
  factory UserCredentialData.fromJson(Map<String, dynamic> json) {
    return UserCredentialData(
      clientId: json['clientId'],
      firstTimeLogin: json['firstTimeLogin'],
      lastLoginTs: json['lastLoginTs'],
      accessToken: json['accessToken'],
      tokenType: json['tokenType'],
      expiresIn: json['expiresIn'],
      refreshToken: json['refreshToken'],
      expires: json['expires'],
      issued: json['issued'],
      userId: json['userId'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      userName: json['userName'],
      email: json['email'],
      phoneCode: json['phoneCode'],
      phoneNumber: json['phoneNumber'],
      otpVerified: json['otpVerified'],
      isVerified: json['isVerified'],
      verifiedDate: json['verifiedDate'],
      isGuest: json['isGuest'],
    );
  }

  // Convert a UserCredentialData object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'firstTimeLogin': firstTimeLogin,
      'lastLoginTs': lastLoginTs,
      'accessToken': accessToken,
      'tokenType': tokenType,
      'expiresIn': expiresIn,
      'refreshToken': refreshToken,
      'expires': expires,
      'issued': issued,
      'userId': userId,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'userName': userName,
      'email': email,
      'phoneCode': phoneCode,
      'phoneNumber': phoneNumber,
      'otpVerified': otpVerified,
      'isVerified': isVerified,
      'verifiedDate': verifiedDate,
      'isGuest': isGuest,
    };
  }
}
