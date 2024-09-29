part of 'operator_dash_board_bloc.dart';

class OperatorDashBoardState extends Equatable {
  final bool isPickupOrder;
  final DetailedUser? operatorInfo;
  final FormStatus status;
  OperatorDashBoardState({this.isPickupOrder = true, this.operatorInfo, status})
      : status = (status != null) ? status : InitialStatus();

  OperatorDashBoardState copyWith({
    bool? isPickupOrder,
    DetailedUser? operatorInfo,
    FormStatus? status,
  }) {
    return OperatorDashBoardState(
      isPickupOrder: isPickupOrder ?? this.isPickupOrder,
      operatorInfo: operatorInfo ?? this.operatorInfo,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [isPickupOrder, operatorInfo, status];
}
