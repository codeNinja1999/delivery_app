import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/kyc_status.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_contact_info.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_document_info.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_identification_info.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_personal_info.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user_wallet_info.dart';

class User {
  UserPersonalInfo personalInfo;
  ContactInfo? userContactInfo;
  UserWalletInfo? walletInfo;
  UserIdentificationInfo? identificationInfo;
  UserDocumentInfo? userDocumentInfo;

  User(
      {required this.personalInfo,
      this.userContactInfo,
      this.walletInfo,
      this.identificationInfo,
      this.userDocumentInfo,
      });
}

class DetailedUser {
  final String? id;
  final String? userName;
  final KYCStatus status;
  final String? promotionalCode;
  final UserWalletInfo? walletInfo;
  final UserPersonalInfo personalInfo;
  final ContactInfo? contactInfo;
  final UserIdentificationInfo? identificationInfo;
  final UserDocumentInfo? userDocumentInfo;

  DetailedUser({
    required this.id,
    required this.userName,
    required this.status,
    this.promotionalCode,
    required this.personalInfo,
    this.contactInfo,
    this.walletInfo,
    this.identificationInfo,
    this.userDocumentInfo,
  });
}
