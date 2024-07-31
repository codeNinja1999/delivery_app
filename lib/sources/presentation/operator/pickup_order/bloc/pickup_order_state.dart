part of 'pickup_order_bloc.dart';

class PickupOrderState extends Equatable {
  final FormStatus status;
  PickupOrderState({status}) : status = (status != null) ? status : InitialStatus();

  PickupOrderState copyWith({
    FormStatus? status,
  }) {
    return PickupOrderState(
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object> get props => [status];
}
