part of 'admin_dashboard_bloc.dart';

class AdminDashboardState extends Equatable {
  final bool isPickupOrder;
  final DetailedUser? userInfo;
  final List<DetailedUser?>? userList;
  final List<DetailedOperator?>? operatorList;
  final DetailedOperator? operatorInfo;
  final FormStatus status;
  AdminDashboardState({
    this.isPickupOrder = false,
    this.userInfo,
    this.userList,
    this.operatorList,
    this.operatorInfo,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  AdminDashboardState copyWith({
    bool? isPickupOrder,
    DetailedUser? userInfo,
    List<DetailedUser?>? userList,
    List<DetailedOperator?>? operatorList,
    DetailedOperator? operatorInfo,
    FormStatus? status,
  }) {
    return AdminDashboardState(
      isPickupOrder: isPickupOrder ?? this.isPickupOrder,
      userInfo: userInfo ?? this.userInfo,
      userList: userList ?? this.userList,
      operatorList: operatorList ?? this.operatorList,
      operatorInfo: operatorInfo ?? this.operatorInfo,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        isPickupOrder,
        userInfo,
        userList,
        operatorList,
        operatorInfo,
        status,
      ];
}
