part of 'personal_information_bloc.dart';

abstract class PersonalInformationEvent {}

class FetchCatalog extends PersonalInformationEvent {}

class UserInfoSubscriptionRequested extends PersonalInformationEvent {}

class FirstNameChanged extends PersonalInformationEvent {
  FirstNameChanged(this.firstName);
  final String firstName;
}

class MiddleNameChanged extends PersonalInformationEvent {
  MiddleNameChanged(this.middleName);
  final String middleName;
}

class LastNameChanged extends PersonalInformationEvent {
  LastNameChanged(this.lastName);
  final String lastName;
}

class GenderChanged extends PersonalInformationEvent {
  GenderChanged(this.gender);
  final Catalog gender;
}

class IdVisaTypeSelected extends PersonalInformationEvent {
  IdVisaTypeSelected(this.idVisaType);
  final Catalog idVisaType;
}

class DateOfBirthSelected extends PersonalInformationEvent {
  DateOfBirthSelected(this.dateOfBirth);
  final String dateOfBirth;
}

class NationalitySelected extends PersonalInformationEvent {
  NationalitySelected(this.nationality);
  final Country nationality;
}

class SetPersonalInfo extends PersonalInformationEvent {
  final UploadUserKycInfo? uploadUserKycInfo;
  SetPersonalInfo({required this.uploadUserKycInfo});
}

class GetOccupation extends PersonalInformationEvent {}

class OccupationOtherSelected extends PersonalInformationEvent {
  final String occupationOther;
  OccupationOtherSelected(this.occupationOther);
}

class OccupationSelected extends PersonalInformationEvent {
  OccupationSelected(this.occupation);
  final Catalog occupation;
}
