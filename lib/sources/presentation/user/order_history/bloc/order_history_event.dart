part of 'order_history_bloc.dart';

abstract class OrderHistoryEvent {}

class TransactionListSubscriptionRequested extends OrderHistoryEvent {}

class GetTransactionList extends OrderHistoryEvent {
  final int pageNumber;
  final bool? refresh;
  GetTransactionList(this.pageNumber, this.refresh);
}

class SearchTextChanged extends OrderHistoryEvent {
  final String? searchString;
  SearchTextChanged(this.searchString);
}

class ValidateTransactionId extends OrderHistoryEvent {
  final String transactionId;
  ValidateTransactionId(this.transactionId);
}
