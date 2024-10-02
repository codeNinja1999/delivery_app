part of 'admin_dashboard_bloc.dart';

abstract class AdminDashboardEvent {}

class GetDashboardData extends AdminDashboardEvent {}

class GetLocation extends AdminDashboardEvent {}

class DeleteLocation extends AdminDashboardEvent {
  final Location? location;
  DeleteLocation(this.location);
}
class GetServiceType extends AdminDashboardEvent {}

class DeleteService extends AdminDashboardEvent {
  final ServiceType? serviceType;
  DeleteService(this.serviceType);
}

class UserInfoSubscriptionRequested extends AdminDashboardEvent {}
