part of 'admin_dashboard_bloc.dart';

abstract class AdminDashboardEvent {}

class GetDashboardData extends AdminDashboardEvent {}

class UserInfoSubscriptionRequested extends AdminDashboardEvent {}
