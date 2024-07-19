part of 'confirm_receipt_bloc.dart';

sealed class ConfirmReceiptEvent {}

class UploadReceipt extends ConfirmReceiptEvent {
final String? tranNo;
  final File? receiptImage;
  final DepositBank? depositBank;
  UploadReceipt({this.tranNo, this.depositBank, this.receiptImage});
}

