import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'pickup_order_event.dart';
part 'pickup_order_state.dart';

class PickupOrderBloc extends Bloc<PickupOrderEvent, PickupOrderState> {
  PickupOrderBloc() : super(PickupOrderState()) {
    on<PickupOrderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
