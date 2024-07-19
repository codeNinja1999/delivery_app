part of 'transaction_detail_bloc.dart';

class TransactionDetailState extends Equatable {
  // final PdfDetailModel? pdfDetailModel;
  final TransactionDetailViewModel? transactionDetailViewModel;
  final ReceiptDetailViewModel? receiptDetailViewModel;
  final ConfirmTransactionResult? confirmTransactionResult;

  final FormStatus? tempStatus;
  final FormStatus status;

  TransactionDetailState({
    this.receiptDetailViewModel,
    this.transactionDetailViewModel,
    this.confirmTransactionResult,
    // this.pdfDetailModel,
    this.tempStatus,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  TransactionDetailState copyWith({
    // PdfDetailModel? pdfDetailModel,
    TransactionDetailViewModel? transactionDetailViewModel,
    ReceiptDetailViewModel? receiptDetailViewModel,
    ConfirmTransactionResult? confirmTransactionResult,
    FormStatus? tempStatus,
    FormStatus? status,
  }) {
    return TransactionDetailState(
      // pdfDetailModel: pdfDetailModel ?? this.pdfDetailModel,
      transactionDetailViewModel: transactionDetailViewModel ?? this.transactionDetailViewModel,
      receiptDetailViewModel: receiptDetailViewModel ?? this.receiptDetailViewModel,
      confirmTransactionResult: confirmTransactionResult ?? this.confirmTransactionResult,
      tempStatus: tempStatus,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        transactionDetailViewModel,
        receiptDetailViewModel,
        confirmTransactionResult,
        // pdfDetailModel,
        tempStatus,
        status
      ];
}
