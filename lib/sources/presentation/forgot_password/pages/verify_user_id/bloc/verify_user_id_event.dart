part of 'verify_user_id_bloc.dart';

abstract class VerifyUserIdEvent {}

class VerifyLoginId extends VerifyUserIdEvent {}

class EmailChanged extends VerifyUserIdEvent {
  EmailChanged(this.email);
  final String email;
}
