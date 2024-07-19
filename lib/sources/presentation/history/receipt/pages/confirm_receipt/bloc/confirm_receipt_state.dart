part of 'confirm_receipt_bloc.dart';

class ConfirmReceiptState extends Equatable {
  final FormStatus status;
  final AzureInfo? azureInfo;
  final String? receiptDocumentName;
  ConfirmReceiptState({
    this.azureInfo,
    this.receiptDocumentName,
    status,
  }) : status = (status != null) ? status : InitialStatus();

  ConfirmReceiptState copyWith({
    AzureInfo? azureInfo,
    String? receiptDocumentName,
    FormStatus? status,
  }) {
    return ConfirmReceiptState(
      azureInfo: azureInfo ?? this.azureInfo,
      receiptDocumentName: receiptDocumentName ?? this.receiptDocumentName,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [azureInfo, receiptDocumentName, status];
}
