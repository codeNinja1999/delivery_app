part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent {}

class FirstNameChanged extends EditProfileEvent {
  final String firstName;
  FirstNameChanged(this.firstName);
}

class MiddleNameChanged extends EditProfileEvent {
  final String middleName;
  MiddleNameChanged(this.middleName);
}

class LastNameChanged extends EditProfileEvent {
  final String lastName;
  LastNameChanged(this.lastName);
}

class UserNameChanged extends EditProfileEvent {
  final String userName;
  UserNameChanged(this.userName);
}

class PhoneNumberChanged extends EditProfileEvent {
  final String phoneNumber;
  PhoneNumberChanged(this.phoneNumber);
}

class HouseNumberChanged extends EditProfileEvent {
  final String houseNumber;
  HouseNumberChanged(this.houseNumber);
}

class AdditionalInformationChanged extends EditProfileEvent {
  final String additionalInformation;
  AdditionalInformationChanged(this.additionalInformation);
}

class SubmitEditProfile extends EditProfileEvent {}
