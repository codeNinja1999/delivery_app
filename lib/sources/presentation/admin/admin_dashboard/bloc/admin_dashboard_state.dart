part of 'admin_dashboard_bloc.dart';

class AdminDashboardState extends Equatable {
  final bool isPickupOrder;
  final DetailedUser? userInfo;
  final List<DetailedUser>? userList;
  final List<DetailedOperator>? operatorList;
  final DetailedOperator? operatorInfo;
  final List<Location>? locationList;
  final AnalyticDataInfo? analyticsInfo;
  final List<ServiceType>? serviceTypeList;

  final FormStatus status;
  AdminDashboardState({
    this.isPickupOrder = false,
    this.userInfo,
    this.userList,
    this.operatorList,
    this.operatorInfo,
    this.locationList,
    this.analyticsInfo,
    this.serviceTypeList,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  AdminDashboardState copyWith({
    bool? isPickupOrder,
    DetailedUser? userInfo,
    List<DetailedUser>? userList,
    List<DetailedOperator>? operatorList,
    DetailedOperator? operatorInfo,
    List<Location>? locationList,
    AnalyticDataInfo? analyticsInfo,
    List<ServiceType>? serviceTypeList,
    FormStatus? status,
  }) {
    return AdminDashboardState(
      userInfo: userInfo ?? this.userInfo,
      userList: userList ?? this.userList,
      operatorList: operatorList ?? this.operatorList,
      operatorInfo: operatorInfo ?? this.operatorInfo,
      locationList: locationList ?? this.locationList,
      analyticsInfo: analyticsInfo ?? this.analyticsInfo,
      isPickupOrder: isPickupOrder ?? this.isPickupOrder,
      serviceTypeList: serviceTypeList ?? this.serviceTypeList,
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
        locationList,
        analyticsInfo,
        serviceTypeList,
        status,
      ];
}
