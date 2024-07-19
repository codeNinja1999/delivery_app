class UploadPaymentRequest {
  final String? receiptImage;
  final String? tranno;
  final String? depositBankId;

  UploadPaymentRequest({
    this.receiptImage,
    this.tranno,
    this.depositBankId,
  });

  Map<String, dynamic> toJson() => {
        "receipt": receiptImage,
        "tranno": tranno,
        "deposit_bank_id": depositBankId,
      };
}
