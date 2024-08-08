import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  OrderHistoryBloc() : super(OrderHistoryState()) {
    on<ValidateTransactionId>(_onValidateTransactionId);
  }

  void _onValidateTransactionId(
    ValidateTransactionId event,
    Emitter<OrderHistoryState> emit,
  ) {
    if (event.transactionId.isNotEmpty) {
      emit(state.copyWith(transactionId: event.transactionId, status: Success()));
    } else {
      emit(state.copyWith(status: SubmissionFailure(Exception("Transaction Id is empty"))));
    }
  }
}
