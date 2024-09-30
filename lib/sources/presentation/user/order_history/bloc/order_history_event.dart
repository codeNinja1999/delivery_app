part of 'order_history_bloc.dart';

abstract class OrderHistoryEvent {}

class TransactionListSubscriptionRequested extends OrderHistoryEvent {}

class GetOrderHistory extends OrderHistoryEvent {
  final int pageNumber;
  GetOrderHistory(this.pageNumber);
}

class SearchTextChanged extends OrderHistoryEvent {
  final String? searchString;
  SearchTextChanged(this.searchString);
}

class ValidateTransactionId extends OrderHistoryEvent {
  final String transactionId;
  ValidateTransactionId(this.transactionId);
}
