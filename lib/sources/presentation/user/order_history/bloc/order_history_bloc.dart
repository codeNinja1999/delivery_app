import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../model/transaction_list_view_model.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final TransactionActivityRepository transactionActivityRepository;

  OrderHistoryBloc({required this.transactionActivityRepository}) : super(OrderHistoryState()) {
    on<SearchTextChanged>(_onSearchTextChanged);
    on<ValidateTransactionId>(_onValidateTransactionId);
  }


  void _onSearchTextChanged(
    SearchTextChanged event,
    Emitter<OrderHistoryState> emit,
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
    Emitter<OrderHistoryState> emit,
  ) {
    if (event.transactionId.isNotEmpty) {
      emit(state.copyWith(transactionId: event.transactionId, status: Success()));
    } else {
      emit(state.copyWith(status: SubmissionFailure(Exception("Transaction Id is empty"))));
    }
  }
}
