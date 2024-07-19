class ExchangeRateResponseModel {
  ExchangeRateResponseModel({
    this.sendAgentId,
    this.remittanceAmount,
    this.remittanceFee,
    this.totalAmount,
    this.exchangeRate,
    this.estimatedReceivingAmount,
    this.receivingCurrencyCode,
    this.csDepositFee,
    this.counterCurrency,
    this.accountBalance,
    this.bonusAmt,
    this.remittanceAmountAfterPromo,
    this.serviceChargeAfterPromo,
    this.freeTxn,
    this.taxAmount,
    this.taxType,
    this.processResult,
  });

  final String? sendAgentId;
  final String? remittanceAmount;
  final double? remittanceFee;
  final String? totalAmount;
  final String? exchangeRate;
  final String? estimatedReceivingAmount;
  final String? receivingCurrencyCode;
  final String? csDepositFee;
  final String? counterCurrency;
  final String? accountBalance;
  final String? bonusAmt;
  final String? remittanceAmountAfterPromo;
  final String? serviceChargeAfterPromo;
  final String? freeTxn;
  final String? taxAmount;
  final String? taxType;
  final bool? processResult;

  factory ExchangeRateResponseModel.fromJson(Map<String, dynamic> json) =>
      ExchangeRateResponseModel(
        sendAgentId: json["send_agent_id"],
        remittanceAmount: json["remittance_amount"],
        remittanceFee: json["remittance_fee"],
        totalAmount: json["total_amount"],
        exchangeRate: json["exchange_rate"],
        estimatedReceivingAmount: json["estimated_receiving_amount"],
        receivingCurrencyCode: json["receiving_currency_code"],
        csDepositFee: json["cs_deposit_fee"],
        counterCurrency: json["counter_currency"],
        accountBalance: json["account_balance"],
        bonusAmt: json["bonus_amt"],
        remittanceAmountAfterPromo: json["remittance_amount_after_promo"],
        serviceChargeAfterPromo: json["service_charge_after_promo"],
        freeTxn: json["free_txn"],
        taxAmount: json["tax_amount"],
        taxType: json["tax_type"],
        processResult: json["process_result"],
      );

  Map<String, dynamic> toJson() => {
        "send_agent_id": sendAgentId,
        "remittance_amount": remittanceAmount,
        "remittance_fee": remittanceFee,
        "total_amount": totalAmount,
        "exchange_rate": exchangeRate,
        "estimated_receiving_amount": estimatedReceivingAmount,
        "receiving_currency_code": receivingCurrencyCode,
        "cs_deposit_fee": csDepositFee,
        "counter_currency": counterCurrency,
        "account_balance": accountBalance,
        "bonus_amt": bonusAmt,
        "remittance_amount_after_promo": remittanceAmountAfterPromo,
        "service_charge_after_promo": serviceChargeAfterPromo,
        "free_txn": freeTxn,
        "tax_amount": taxAmount,
        "tax_type": taxType,
        "process_result": processResult,
      };
}
