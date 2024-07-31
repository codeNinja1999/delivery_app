import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'operator_dash_board_event.dart';
part 'operator_dash_board_state.dart';

class OperatorDashBoardBloc extends Bloc<OperatorDashBoardEvent, OperatorDashBoardState> {
  OperatorDashBoardBloc() : super(OperatorDashBoardState()) {
    on<TogglePickupOrder>(_onTogglePickupOrder);
  }

  _onTogglePickupOrder(TogglePickupOrder event, Emitter<OperatorDashBoardState> emit) {
    emit(state.copyWith(isPickupOrder: !state.isPickupOrder));
  }
}
