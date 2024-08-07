import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../model/transaction_list_view_model.dart';

part 'operator_history_event.dart';
part 'operator_history_state.dart';

class OperatorHistoryBloc extends Bloc<OperatorHistoryEvent, OperatorHistoryState> {
  final TransactionActivityRepository transactionActivityRepository;

  OperatorHistoryBloc({required this.transactionActivityRepository}) : super(OperatorHistoryState()) {
    on<SearchTextChanged>(_onSearchTextChanged);
    on<ValidateTransactionId>(_onValidateTransactionId);
  }

  void _onSearchTextChanged(
    SearchTextChanged event,
    Emitter<OperatorHistoryState> emit,
  ) {
    List<TransactionListViewModel>? filteredReceiverList = [];
    if (event.searchString == "") {
      filteredReceiverList = state.defaultTransactionList;
    } else {
      filteredReceiverList = (state.defaultTransactionList.isNotEmpty)
          ? state.defaultTransactionList
              .where(
                (transaction) => (transaction.beneficiaryName != null)
                    ? transaction.beneficiaryName!.toLowerCase().contains(event.searchString!.toLowerCase())
                    : false,
              )
              .toList()
          : [];
    }
    emit(state.copyWith(transactionList: filteredReceiverList));
  }

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
