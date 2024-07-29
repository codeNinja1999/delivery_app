part of 'order_history_bloc.dart';

class OrderHistoryState extends Equatable {
  final List<TransactionListViewModel> defaultTransactionList;
  final List<TransactionListViewModel> transactionList;
  final String? transactionId;
  final int pageNumber;
  final bool paginationEnd;
  final FormStatus status;
  final FormStatus paginationStatus;

  OrderHistoryState({
    this.defaultTransactionList = const [],
    this.transactionList = const [],
    this.transactionId,
    this.pageNumber = 1,
    this.paginationEnd = false,
    paginationStatus,
    status,
  })  : paginationStatus = (paginationStatus != null) ? paginationStatus : InitialStatus(),
        status = (status != null) ? status : InitialStatus();

  OrderHistoryState copyWith({
    List<TransactionListViewModel>? defaultTransactionList,
    List<TransactionListViewModel>? transactionList,
    String? transactionId,
    FormStatus? status,
    int? pageNumber,
    bool? paginationEnd,
    FormStatus? paginationStatus,
  }) {
    return OrderHistoryState(
      defaultTransactionList: defaultTransactionList ?? this.defaultTransactionList,
      transactionList: transactionList ?? this.transactionList,
      transactionId: transactionId ?? this.transactionId,
      status: status ?? InitialStatus(),
      pageNumber: pageNumber ?? this.pageNumber,
      paginationEnd: paginationEnd ?? this.paginationEnd,
      paginationStatus: paginationStatus ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [
        defaultTransactionList,
        transactionList,
        transactionId,
        status,
        pageNumber,
        paginationEnd,
      ];
}
