import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_contact_info.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_personal_info.dart';

class User {
  UserPersonalInfo? personalInfo;
  UserContactInfo? contactInfo;

  User({
    this.personalInfo,
    this.contactInfo,
  });
}

class DetailedUser {
  final String? id;
  final UserPersonalInfo? personalInfo;
  final UserContactInfo? contactInfo;

  DetailedUser({
    this.id,
    this.personalInfo,
    this.contactInfo,
  });
}
