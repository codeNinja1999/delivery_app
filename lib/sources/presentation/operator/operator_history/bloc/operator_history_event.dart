part of 'operator_history_bloc.dart';

abstract class OperatorHistoryEvent {}

class TransactionListSubscriptionRequested extends OperatorHistoryEvent {}

class GetTransactionList extends OperatorHistoryEvent {
  final int pageNumber;
  final bool? refresh;
  GetTransactionList(this.pageNumber, this.refresh);
}

class SearchTextChanged extends OperatorHistoryEvent {
  final String? searchString;
  SearchTextChanged(this.searchString);
}

class ValidateTransactionId extends OperatorHistoryEvent {
  final String transactionId;
  ValidateTransactionId(this.transactionId);
}
