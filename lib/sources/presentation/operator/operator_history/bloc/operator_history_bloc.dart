import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'operator_history_event.dart';
part 'operator_history_state.dart';

class OperatorHistoryBloc extends Bloc<OperatorHistoryEvent, OperatorHistoryState> {
  OperatorHistoryBloc() : super(OperatorHistoryState()) {
    on<SearchTextChanged>(_onSearchTextChanged);
    on<ValidateTransactionId>(_onValidateTransactionId);
  }

  void _onSearchTextChanged(
    SearchTextChanged event,
    Emitter<OperatorHistoryState> emit,
  ) {}

  void _onValidateTransactionId(
    ValidateTransactionId event,
    Emitter<OperatorHistoryState> emit,
  ) {
    if (event.transactionId.isNotEmpty) {
      emit(state.copyWith(transactionId: event.transactionId, status: Success()));
    } else {
      emit(state.copyWith(status: SubmissionFailure(Exception("Transaction Id is empty"))));
    }
  }
}
