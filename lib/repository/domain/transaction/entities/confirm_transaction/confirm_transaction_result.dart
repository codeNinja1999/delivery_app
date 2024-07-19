class ConfirmTransactionResult {
  final String? message;
  final String? referenceID;
  final String? senderName;
  final String? promptPayQr;
  final String? collectAmount;
  final String? paymentType;
  final String? collectCurrency;
  final String? payoutAmount;
  final String? payoutCurrency;
  final String? apiTokenId;
  final String? status;
  final String? sendMode;
  final String? isPinOnHold;

  ConfirmTransactionResult({
    this.message,
    this.referenceID,
    this.senderName,
    this.promptPayQr,
    this.paymentType,
    this.collectAmount,
    this.collectCurrency,
    this.apiTokenId,
    this.payoutAmount,
    this.payoutCurrency,
    this.sendMode,
    this.status,
    this.isPinOnHold,
  });
}
