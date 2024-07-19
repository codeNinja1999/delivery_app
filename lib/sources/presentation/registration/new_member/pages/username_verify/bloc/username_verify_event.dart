part of 'username_verify_bloc.dart';

abstract class UsernameVerifyEvent {}

class VerifyUserID extends UsernameVerifyEvent {}

class IsEmailType extends UsernameVerifyEvent {
  final bool isEmail;
  IsEmailType(this.isEmail);
}

class UserIdChanged extends UsernameVerifyEvent {
  final String userId;
  UserIdChanged(this.userId);
}
