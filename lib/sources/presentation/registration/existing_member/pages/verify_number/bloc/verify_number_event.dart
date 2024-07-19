part of 'verify_number_bloc.dart';

abstract class VerifyNumberEvent {}

class VerifyUserID extends VerifyNumberEvent {}

class UserIdChanged extends VerifyNumberEvent {
  final String userId;
  UserIdChanged(this.userId);
}
