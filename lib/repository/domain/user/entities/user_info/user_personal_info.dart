import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalogs.dart';

class UserPersonalInfo {
  final EnglishName? nameEnglish;
  final String? fullName;
  final Catalog? gender;
  final String? dateOfBirth;
  final Catalog? nationality;

  UserPersonalInfo({
    this.nameEnglish,
    this.fullName,
    this.gender,
    this.dateOfBirth,
    this.nationality,
  });
}

class EnglishName {
  final String? firstName;
  final String? middleName;
  final String? lastName;

  EnglishName({this.firstName, this.middleName, this.lastName});
}
