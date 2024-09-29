part of 'operator_profile_bloc.dart';

abstract class OperatorProfileEvent {}

class GetOperatorInfo extends OperatorProfileEvent {}

class OperatorInfoSubscriptionRequested extends OperatorProfileEvent {}

class LogoutUser extends OperatorProfileEvent {}
