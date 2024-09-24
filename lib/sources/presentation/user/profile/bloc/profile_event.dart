part of 'profile_bloc.dart';

abstract class ProfileEvent {
}
class LogoutUser extends ProfileEvent {}

class GetUserData extends ProfileEvent {}

class UserInfoSubscriptionRequested extends ProfileEvent {}