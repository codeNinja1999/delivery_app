part of 'operator_dash_board_bloc.dart';

abstract class OperatorDashBoardEvent {}

class GetOperatorInfo extends OperatorDashBoardEvent {}

class GetPickupOrder extends OperatorDashBoardEvent {}

class GetDeliveryOrder extends OperatorDashBoardEvent {}

class OperatorInfoSubscriptionRequested extends OperatorDashBoardEvent {}

class TogglePickupOrder extends OperatorDashBoardEvent {}
