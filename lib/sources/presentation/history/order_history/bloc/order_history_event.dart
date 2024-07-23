part of 'order_history_bloc.dart';

abstract class TransactionListEvent {}

class TransactionListSubscriptionRequested extends TransactionListEvent {}

class GetTransactionList extends TransactionListEvent {
  final int pageNumber;
  final bool? refresh;
  GetTransactionList(this.pageNumber, this.refresh);
}

class SearchTextChanged extends TransactionListEvent {
  final String? searchString;
  SearchTextChanged(this.searchString);
}

class ValidateTransactionId extends TransactionListEvent {
  final String transactionId;
  ValidateTransactionId(this.transactionId);
}
