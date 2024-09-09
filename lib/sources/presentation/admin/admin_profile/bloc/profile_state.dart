part of 'profile_bloc.dart';

class AdminProfileState extends Equatable {
  final DetailedUser? userInfo;
  final FormStatus status;

  AdminProfileState({this.userInfo, status}) : status = (status != null) ? status : InitialStatus();

  AdminProfileState copyWith({
    DetailedUser? userInfo,
    FormStatus? status,
  }) {
    return AdminProfileState(
      userInfo: userInfo ?? userInfo,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [userInfo, status];
}
