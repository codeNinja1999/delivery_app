import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_contact_info.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_personal_info.dart';

class User {
  UserPersonalInfo? personalInfo;
  UserContactInfo? contactInfo;
  String? additionalInformation;

  User({
    this.personalInfo,
    this.contactInfo,
    this.additionalInformation,
  });
}

class DetailedUser {
  final String? id;
  final UserPersonalInfo? personalInfo;
  final UserContactInfo? contactInfo;
  final String? additionalInformation;

  DetailedUser({
    this.id,
    this.personalInfo,
    this.contactInfo,
    this.additionalInformation,
  });
}

class OperatorUser extends User {
  final String password;
  final String confirmPassword;
  OperatorUser({required this.password, required this.confirmPassword, required super.personalInfo});
}
