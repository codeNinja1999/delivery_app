import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalogs.dart';

class UserPersonalInfo {
  final EnglishName? nameEnglish;
  final String? nameAlternative;
  final String? fullName;
  final Catalog? gender;
  final String? dateOfBirth;
  final String? birtPlace;
  final Catalog? nationality;
  final Catalog? visaType;
  final Catalog? occupation;
  final String? occupationAlternative;
  final Catalog? sourceOfIncome;
  final String? sourceOfIncomeAlternative;
  final String? isTradePinEnabled;
  final Catalog? maritalStatus;
  final Catalog? monthlyIncome;
  final String? residentialAddress;

  UserPersonalInfo({
    this.nameEnglish,
    this.nameAlternative,
    this.fullName,
    this.gender,
    this.dateOfBirth,
    this.birtPlace,
    this.nationality,
    this.occupation,
    this.visaType,
    this.occupationAlternative,
    this.sourceOfIncome,
    this.sourceOfIncomeAlternative,
    this.isTradePinEnabled,
    this.maritalStatus,
    this.monthlyIncome,
    this.residentialAddress,
  });
}

class EnglishName {
  final String? firstName;
  final String? middleName;
  final String? lastName;

  EnglishName({this.firstName, this.middleName, this.lastName});
}
