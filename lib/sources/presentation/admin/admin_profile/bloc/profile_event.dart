part of 'profile_bloc.dart';

abstract class AdminProfileEvent {}

class GetAdminInfo extends AdminProfileEvent {}

class AdminInfoSubscriptionRequested extends AdminProfileEvent {}

class LogoutUser extends AdminProfileEvent {}
