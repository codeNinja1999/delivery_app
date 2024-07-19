part of 'receipt_bloc.dart';

class ReceiptState extends Equatable {
  final String? tranNo;
  final FormStatus status;
  final File? receiptImage;
  final AzureInfo? azureInfo;
  final DepositBank? depositBank;

  ReceiptState({
    this.tranNo,
    this.receiptImage,
    this.depositBank,
    this.azureInfo,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  ReceiptState copyWith({
    String? tranNo,
    File? receiptImage,
    DepositBank? depositBank,
    AzureInfo? azureInfo,
    FormStatus? status,
  }) {
    return ReceiptState(
      tranNo: tranNo ?? this.tranNo,
      receiptImage: receiptImage ?? this.receiptImage,
      depositBank: depositBank ?? this.depositBank,
      azureInfo: azureInfo ?? this.azureInfo,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [ azureInfo, depositBank,  tranNo, status];
}
