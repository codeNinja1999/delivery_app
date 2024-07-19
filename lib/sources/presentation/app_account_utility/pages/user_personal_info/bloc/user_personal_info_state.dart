part of 'user_personal_info_bloc.dart';

class UserPersonalInfoState extends Equatable {
  final UserPersonalInfoViewModel? personalInfoViewModel;
  final ChangeProfilePicList? profileImage;
  final FormStatus status;

  UserPersonalInfoState({this.personalInfoViewModel, this.profileImage, status})
      : status = (status != null) ? status : InitialStatus();

  UserPersonalInfoState copyWith({
    UserPersonalInfoViewModel? personalInfoViewModel,
    ChangeProfilePicList? profileImage,
    FormStatus? status,
  }) {
    return UserPersonalInfoState(
      personalInfoViewModel: personalInfoViewModel ?? this.personalInfoViewModel,
      profileImage: profileImage ?? this.profileImage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, personalInfoViewModel, profileImage];
}
