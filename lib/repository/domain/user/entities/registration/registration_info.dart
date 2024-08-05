import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_document_info.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_identification_info.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_personal_info.dart';

class RegistrationInfo {
  UserPersonalInfo personalInfo;
  UserIdentificationInfo? identificationInfo;
  UserDocumentInfo? userDocumentInfo;

  RegistrationInfo({
    required this.personalInfo,
    this.identificationInfo,
    this.userDocumentInfo,
  });
}
