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
    on<GetTransactionList>(_onGetTransactionList);
    on<SearchTextChanged>(_onSearchTextChanged);
    on<ValidateTransactionId>(_onValidateTransactionId);
    on<TransactionListSubscriptionRequested>(_transactionListSubscriptionRequested);
  }

  Future<void> _transactionListSubscriptionRequested(
    TransactionListSubscriptionRequested event,
    Emitter<OrderHistoryState> emit,
  ) async {
    await emit.forEach<List<DetailedTransaction>?>(
      transactionActivityRepository.transactionList(),
      onData: (transactionList) {
        if (transactionList != null) {
          final receiverListItemViewModels =
              transactionList.map((item) => TransactionListViewModel.fromTransaction(item)).toList();
          if (state.pageNumber != 1) {
            if (transactionList.isEmpty) {
              return state.copyWith(paginationEnd: true);
            }
            List<TransactionListViewModel> updatedList = state.defaultTransactionList;
            updatedList.addAll(receiverListItemViewModels);
            return state.copyWith(
              defaultTransactionList: updatedList,
              transactionList: updatedList,
              paginationStatus: InitialStatus(),
            );
          } else {
            return state.copyWith(
              defaultTransactionList: receiverListItemViewModels,
              transactionList: receiverListItemViewModels,
            );
          }
        } else {
          return state.copyWith(status: InitialStatus());
        }
      },
      onError: (error, __) {
        final failure = error as Exception;
        return state.copyWith(status: SubmissionFailure(failure), pageNumber: state.pageNumber - 1);
      },
    );
  }

  Future<void> _onGetTransactionList(
    GetTransactionList event,
    Emitter<OrderHistoryState> emit,
  ) async {
    if (state.paginationStatus is InProgress) {
      return;
    }
    emit(state.copyWith(
      pageNumber: event.pageNumber,
      paginationEnd: false,
      paginationStatus: InProgress(),
      status: event.refresh ?? false ? InProgress() : InitialStatus(),
    ));

    final filter = TransactionListFilter(
      pageNumber: event.pageNumber.toString(),
      itemCount: "20",
      startDate: "",
      endDate: "",
      issueType: "02",
    );
    await transactionActivityRepository.getTransactionList(filter);
    emit(state.copyWith(
      paginationStatus: InitialStatus(),
      status: InitialStatus(),
    ));
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
