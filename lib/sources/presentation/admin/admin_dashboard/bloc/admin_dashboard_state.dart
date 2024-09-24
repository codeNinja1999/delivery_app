part of 'admin_dashboard_bloc.dart';

class AdminDashboardState extends Equatable {
  final bool isPickupOrder;
  final DetailedUser? userInfo;
  final FormStatus status;
  AdminDashboardState({this.isPickupOrder = true, this.userInfo, status})
      : status = (status != null) ? status : InitialStatus();

  AdminDashboardState copyWith({
    bool? isPickupOrder,
    DetailedUser? userInfo,
    FormStatus? status,
  }) {
    return AdminDashboardState(
      isPickupOrder: isPickupOrder ?? this.isPickupOrder,
      userInfo: userInfo ?? this.userInfo,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [isPickupOrder, userInfo, status];
}
