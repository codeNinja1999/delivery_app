import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_contact_info.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_personal_info.dart';

class User {
  UserPersonalInfo? personalInfo;
  UserContactInfo? contactInfo;
  final String? password;
  final String? confirmPassword;
  String? additionalInformation;

  User({
    this.personalInfo,
    this.contactInfo,
    this.password,
    this.confirmPassword,
    this.additionalInformation,
  });
}

class DetailedUser {
  final String? id;
  final UserPersonalInfo? personalInfo;
  final UserContactInfo? contactInfo;
  final String? password;
  final String? confirmPassword;
  final String? additionalInformation;

  DetailedUser({
    this.id,
    this.personalInfo,
    this.contactInfo,
    this.password,
    this.confirmPassword,
    this.additionalInformation,
  });
}
