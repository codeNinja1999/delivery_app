part of 'user_personal_info_bloc.dart';

abstract class UserPersonalInfoEvent {
  const UserPersonalInfoEvent();
}

class GetPersonalInfo extends UserPersonalInfoEvent {}

class UserInfoSubscriptionRequested extends UserPersonalInfoEvent {}
class GetLocalImage extends UserPersonalInfoEvent {}

class ChangeProfilePic extends UserPersonalInfoEvent {
  final File? profileImage;
  ChangeProfilePic(this.profileImage);
}

class GetImage extends UserPersonalInfoEvent {
  final ScanBy scanBy;
  GetImage(this.scanBy);
}