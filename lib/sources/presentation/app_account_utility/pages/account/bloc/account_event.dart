part of 'account_bloc.dart';

abstract class AccountEvent {}

class LogoutUser extends AccountEvent {}

class AccountInfoSubscriptionRequested extends AccountEvent {}
