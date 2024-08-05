part of 'admin_dashboard_bloc.dart';

class AdminDashboardState extends Equatable {
  final bool isPickupOrder;
  final FormStatus status;
  AdminDashboardState({this.isPickupOrder = true, status}) : status = (status != null) ? status : InitialStatus();

  AdminDashboardState copyWith({
    bool? isPickupOrder,
    FormStatus? status,
  }) {
    return AdminDashboardState(
      isPickupOrder: isPickupOrder ?? this.isPickupOrder,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object> get props => [isPickupOrder, status];
}
