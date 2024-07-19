part of 'verify_user_id_bloc.dart';

abstract class VerifyUserIdEvent {}

class VerifyLoginId extends VerifyUserIdEvent {}

class UserIdChanged extends VerifyUserIdEvent {
  UserIdChanged(this.userId);
  final String userId;
}

class IsEmailType extends VerifyUserIdEvent {
  final bool isEmail;
  IsEmailType(this.isEmail);
}
