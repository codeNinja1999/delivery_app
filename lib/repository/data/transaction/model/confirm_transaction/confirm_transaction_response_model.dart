class ConfirmTransactionResponse {
  String? message;
  String? refId;
  String? senderName;
  String? collectAmt;
  String? collectCurrency;
  String? payoutamt;
  String? payoutcurrency;
  String? status;
  String? accountName;
  String? accountNo;
  String? isPinOnHold;
  String? paymentType;
  String? tranno;
  String? promptPayQr;
  String? apiTokenId;
  String? sendMode;

  ConfirmTransactionResponse({
    this.message,
    this.refId,
    this.senderName,
    this.collectAmt,
    this.collectCurrency,
    this.payoutamt,
    this.payoutcurrency,
    this.accountName,
    this.accountNo,
    this.status,
    this.isPinOnHold,
    this.paymentType,
    this.tranno,
    this.promptPayQr,
    this.apiTokenId,
    this.sendMode,
  });

  factory ConfirmTransactionResponse.fromJson(Map<String, dynamic> json) => ConfirmTransactionResponse(
      message: json["message"],
      refId: json["refId"],
      senderName: json["sender_name"],
      collectAmt: json["collect_amt"],
      collectCurrency: json["collect_currency"],
      payoutamt: json["payoutamt"],
      payoutcurrency: json["payoutcurrency"],
      status: json["status"],
      accountName: json["account_name"],
      accountNo: json["account_no"],
      isPinOnHold: json["isPinOnHold"],
      paymentType: json["payment_type"],
      tranno: json["tranno"],
      promptPayQr: json["prompt_pay_qr"],
      apiTokenId: json["api_token_id"],
      sendMode: json["send_mode"]);
}
