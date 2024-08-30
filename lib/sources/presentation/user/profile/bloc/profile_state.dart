part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final DetailedUser? userInfo;
  final FormStatus status;

  ProfileState({this.userInfo, status}) : status = (status != null) ? status : InitialStatus();

  ProfileState copyWith({
    DetailedUser? userInfo,
    FormStatus? status,
  }) {
    return ProfileState(
      userInfo: userInfo ?? userInfo,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [userInfo, status];
}
