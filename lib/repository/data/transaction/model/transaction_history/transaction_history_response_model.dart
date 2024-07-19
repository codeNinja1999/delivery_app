class TransactionHistoryResponse {
  TransactionHistoryResponse({
    this.totalDataNo,
    this.resultList,
  });

  int? totalDataNo;
  List<TransactionHistoryResultList>? resultList;

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) => TransactionHistoryResponse(
        totalDataNo: json["total_data_no"],
        resultList: List<TransactionHistoryResultList>.from(
            json["result_list"].map((x) => TransactionHistoryResultList.fromJson(x))),
      );
}

class TransactionHistoryResultList {
  TransactionHistoryResultList({
    this.tradeTs,
    this.status,
    this.statusCode,
    this.tradeTypeCode,
    this.senderFirstName,
    this.senderLastName,
    this.beneficiaryFirstName,
    this.beneficiaryLastName,
    this.tradeAmount,
    this.paymentType,
    this.currency,
    this.transactionId,
    this.referenceNumber,
    this.transferNickname,
    this.receivectype,
    this.receiveamt,
    this.isCustomerDeposited,
    this.depositType,
    this.depositTypeName,
  });

  String? tradeTs;
  String? status;
  String? statusCode;
  String? tradeTypeCode;
  String? senderFirstName;
  String? senderLastName;
  String? beneficiaryFirstName;
  String? beneficiaryLastName;
  String? tradeAmount;
  String? paymentType;
  String? currency;
  String? transactionId;
  String? referenceNumber;
  String? transferNickname;
  String? receivectype;
  String? receiveamt;
  String? isCustomerDeposited;
  String? depositType;
  String? depositTypeName;

  factory TransactionHistoryResultList.fromJson(Map<String, dynamic> json) => TransactionHistoryResultList(
        tradeTs: json["trade_ts"],
        status: json["status"],
        statusCode: json["status_code"],
        tradeTypeCode: json["trade_type_code"],
        senderFirstName: json["sender_first_name"],
        senderLastName: json["sender_last_name"],
        beneficiaryFirstName: json["beneficiary_first_name"],
        beneficiaryLastName: json["beneficiary_last_name"],
        tradeAmount: json["trade_amount"],
        paymentType: json["payment_type"],
        currency: json["currency"],
        transactionId: json["transaction_id"],
        referenceNumber: json["reference_number"],
        transferNickname: json["transfer_nickname"],
        receivectype: json["receivectype"],
        receiveamt: json["receiveamt"],
        isCustomerDeposited: json["is_customer_deposited"],
        depositType: json["deposit_type"],
        depositTypeName: json["deposit_type_name"],
      );
}
