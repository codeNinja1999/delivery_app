class TransactionDetailResponseModel {
  TransactionDetailResponseModel({
    this.deliveryAmount,
    this.exchangeRate,
    this.transferFee,
    this.sendAmount,
    this.collectedAmount,
    this.deliveryMethod,
    this.paymentInfo,
    this.bankAccount,
    this.bankBranch,
    this.address,
    this.tradeTs,
    this.bonusAmt,
    this.taxAmount,
    this.status,
    this.statusCode,
    this.senderFirstName,
    this.senderLastName,
    this.beneficiaryFirstName,
    this.beneficiaryMiddleName,
    this.beneficiaryLastName,
    this.transactionId,
    this.beneficiaryTransferNickname,
    this.referenceNumber,
    this.payoutPartnerName,
    this.exchangeBaseCurrencyCode,
    this.exchangeCounterCurrencyCode,
    this.startedDate,
    this.processingDate,
    this.depositedDate,
    this.promptPayQR,
    this.depositType,
    this.bankaccountName,
    this.bankaccountNumber,
    this.receiptImage,
    this.receiverCountry,
  });

  final String? deliveryAmount;
  final String? exchangeRate;
  final String? transferFee;
  final String? sendAmount;
  final String? collectedAmount;
  final String? deliveryMethod;
  final String? paymentInfo;
  final String? bankAccount;
  final String? bankBranch;
  final String? address;
  final String? tradeTs;
  final String? bonusAmt;
  final String? taxAmount;
  final String? status;
  final String? statusCode;
  final String? senderFirstName;
  final String? senderLastName;
  final String? beneficiaryFirstName;
  final String? beneficiaryMiddleName;
  final String? beneficiaryLastName;
  final String? transactionId;
  final String? beneficiaryTransferNickname;
  final String? referenceNumber;
  final String? payoutPartnerName;
  final String? exchangeBaseCurrencyCode;
  final String? exchangeCounterCurrencyCode;
  final String? startedDate;
  final String? processingDate;
  final String? depositedDate;
  final String? promptPayQR;
  final String? depositType;
  final String? bankaccountName;
  final String? bankaccountNumber;
  final String? receiptImage;
  final String? receiverCountry;

  factory TransactionDetailResponseModel.fromJson(Map<String, dynamic> json) => TransactionDetailResponseModel(
        deliveryAmount: json["delivery_amount"],
        exchangeRate: json["exchange_rate"],
        transferFee: json["transfer_fee"],
        sendAmount: json["send_amount"],
        collectedAmount: json["collected_amount"],
        deliveryMethod: json["delivery_method"],
        paymentInfo: json["payment_info"],
        bankAccount: json["bank_account"],
        bankBranch: json["bank_branch"],
        address: json["address"],
        tradeTs: json["trade_ts"],
        bonusAmt: json["bonus_amt"],
        taxAmount: json["tax_amount"],
        status: json["status"],
        statusCode: json["status_code"],
        senderFirstName: json["sender_first_name"],
        senderLastName: json["sender_last_name"],
        beneficiaryFirstName: json["beneficiary_first_name"],
        beneficiaryMiddleName: json["beneficiary_middle_name"],
        beneficiaryLastName: json["beneficiary_last_name"],
        transactionId: json["transaction_id"],
        beneficiaryTransferNickname: json["beneficiary_transfer_nickname"],
        referenceNumber: json["reference_number"],
        payoutPartnerName: json["payout_partner_name"],
        exchangeBaseCurrencyCode: json["exchange_base_currency_code"],
        exchangeCounterCurrencyCode: json["exchange_counter_currency_code"],
        startedDate: json["started_date"],
        processingDate: json["processing_date"],
        depositedDate: json["deposited_date"],
        promptPayQR: json["prompt_pay_qr"],
        depositType: json["deposit_type"],
        bankaccountName: json["account_name"],
        bankaccountNumber: json["account_no"],
        receiptImage: json["receipt_image"],
        receiverCountry: json["receivercountry"],
      );
}
