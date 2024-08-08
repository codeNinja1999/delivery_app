part of 'operator_history_bloc.dart';

class OperatorHistoryState extends Equatable {
  final String? transactionId;
  final int pageNumber;
  final bool paginationEnd;
  final FormStatus status;
  final FormStatus paginationStatus;

  OperatorHistoryState({
    this.transactionId,
    this.pageNumber = 1,
    this.paginationEnd = false,
    paginationStatus,
    status,
  })  : paginationStatus = (paginationStatus != null) ? paginationStatus : InitialStatus(),
        status = (status != null) ? status : InitialStatus();

  OperatorHistoryState copyWith({
    String? transactionId,
    FormStatus? status,
    int? pageNumber,
    bool? paginationEnd,
    FormStatus? paginationStatus,
  }) {
    return OperatorHistoryState(
      transactionId: transactionId ?? this.transactionId,
      status: status ?? InitialStatus(),
      pageNumber: pageNumber ?? this.pageNumber,
      paginationEnd: paginationEnd ?? this.paginationEnd,
      paginationStatus: paginationStatus ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [
        transactionId,
        status,
        pageNumber,
        paginationEnd,
      ];
}
