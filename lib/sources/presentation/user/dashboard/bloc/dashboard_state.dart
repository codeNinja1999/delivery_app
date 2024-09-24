part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final FormStatus status;
  final DetailedUser? userInfo;

  DashboardState({
    this.userInfo,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  DashboardState copyWith({
    DetailedUser? userInfo,
    FormStatus? status,
  }) {
    return DashboardState(
      userInfo: userInfo ?? this.userInfo,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [userInfo, status];
}
