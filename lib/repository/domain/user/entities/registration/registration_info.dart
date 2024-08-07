import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_personal_info.dart';

import '../user_info/user_contact_info.dart';

class RegistrationInfo {
  UserPersonalInfo? personalInfo;
  UserContactInfo? contactInfo;

  RegistrationInfo({
    this.personalInfo,
    this.contactInfo,
  });
}
