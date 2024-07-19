part of 'receipt_bloc.dart';

abstract class ReceiptEvent {}

class GetLocalImage extends ReceiptEvent {
  final ScanBy scanBy;
  GetLocalImage(this.scanBy);
}

class GetTransactionId extends ReceiptEvent {
  final String? transactionId;
  GetTransactionId(this.transactionId);
}

class SaveDepositBank extends ReceiptEvent {
  final DepositBank? depositBank;
  SaveDepositBank(this.depositBank);
}

class SaveAzureInfo extends ReceiptEvent {
  final AzureInfo? azureInfo;
  SaveAzureInfo(this.azureInfo);
}
