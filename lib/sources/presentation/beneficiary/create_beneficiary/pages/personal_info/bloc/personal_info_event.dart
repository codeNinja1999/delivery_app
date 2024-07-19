part of 'personal_info_bloc.dart';

abstract class PersonalInfoEvent {}

class SaveBeneficiaryPersonalInfo extends PersonalInfoEvent {}

class GetCatalog extends PersonalInfoEvent {}

class FullNameChanged extends PersonalInfoEvent {
  FullNameChanged(this.fullName);
  final String fullName;
}

class SetBeneficiaryPersonalInfo extends PersonalInfoEvent {
  final DetailedReceiver? receiver;
  SetBeneficiaryPersonalInfo({this.receiver});
}

class RelationSelected extends PersonalInfoEvent {
  RelationSelected(this.relation);
  final Catalog relation;
}

class RelationOtherDetailChanged extends PersonalInfoEvent {
  RelationOtherDetailChanged(this.relationOtherDetail);
  final String relationOtherDetail;
}

class PhoneNumberChanged extends PersonalInfoEvent {
  final String? phoneNumber;
  PhoneNumberChanged(this.phoneNumber);
}

class GetReceiverPersonalDetail extends PersonalInfoEvent {
  GetReceiverPersonalDetail(this.detailedReceiver, this.isEdit);
  final DetailedReceiver? detailedReceiver;
  final bool isEdit;
}
