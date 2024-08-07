import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/kyc_status.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_contact_info.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_document_info.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_identification_info.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_personal_info.dart';

class User {
  UserPersonalInfo? personalInfo;
  UserContactInfo? contactInfo;
  UserIdentificationInfo? identificationInfo;
  UserDocumentInfo? userDocumentInfo;

  User({
    this.personalInfo,
    this.contactInfo,
    this.identificationInfo,
    this.userDocumentInfo,
  });
}

class DetailedUser {
  final String? id;
  final String? userName;
  final KYCStatus? status;
  final UserPersonalInfo? personalInfo;
  final UserContactInfo? contactInfo;
  final UserIdentificationInfo? identificationInfo;
  final UserDocumentInfo? userDocumentInfo;

  DetailedUser({
     this.id,
     this.userName,
     this.status,
     this.personalInfo,
    this.contactInfo,
    this.identificationInfo,
    this.userDocumentInfo,
  });
}
