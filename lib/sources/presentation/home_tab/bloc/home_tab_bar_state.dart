part of 'home_tab_bar_bloc.dart';

class HomeTabBarState extends Equatable {
  final DetailedUser? userInfo;

  final FormStatus status;

  HomeTabBarState({
    this.userInfo,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  HomeTabBarState copyWith({
    DetailedUser? userInfo,
    FormStatus? status,
  }) {
    return HomeTabBarState(
      userInfo: userInfo ?? this.userInfo,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [userInfo, status];
}
