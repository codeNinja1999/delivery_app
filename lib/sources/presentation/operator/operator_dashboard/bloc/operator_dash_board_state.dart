part of 'operator_dash_board_bloc.dart';

class OperatorDashBoardState extends Equatable {
  final bool isPickupOrder;
  final FormStatus status;
  OperatorDashBoardState({this.isPickupOrder = true, status}) : status = (status != null) ? status : InitialStatus();

  OperatorDashBoardState copyWith({
    bool? isPickupOrder,
    FormStatus? status,
  }) {
    return OperatorDashBoardState(
      isPickupOrder: isPickupOrder ?? this.isPickupOrder,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object> get props => [isPickupOrder, status];
}
