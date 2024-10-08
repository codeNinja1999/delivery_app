part of 'operator_history_bloc.dart';

abstract class OperatorHistoryEvent {}

class TransactionListSubscriptionRequested extends OperatorHistoryEvent {}

class GetOrderHistory extends OperatorHistoryEvent {
  final int pageNumber;
  GetOrderHistory(this.pageNumber);
}

class SearchTextChanged extends OperatorHistoryEvent {
  final String? searchString;
  SearchTextChanged(this.searchString);
}

class ValidateTransactionId extends OperatorHistoryEvent {
  final String transactionId;
  ValidateTransactionId(this.transactionId);
}
