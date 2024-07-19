class CalculateTransactionResponse {
  CalculateTransactionResponse(
      {this.moneygramProcesId,
      this.moneygramMethodId,
      this.sendAgentId,
      this.remittanceAmount,
      this.remittanceFee,
      this.totalAmount,
      this.exchangeRate,
      this.estimatedReceivingAmount,
      this.receivingCurrencyCode,
      this.csDepositFee,
      this.csDepositAmount,
      this.jpDepositFee,
      this.jpDepositAmount,
      this.rcDepositFee,
      this.rcDepositAmount,
      this.baseCurrency,
      this.counterCurrency,
      this.accountBalance,
      this.bonusAmt,
      this.remittanceAmountAfterPromo,
      this.serviceChargeAfterPromo,
      this.freeTxn,
      this.taxAmount,
      this.taxType,
      this.processResult});

  String? moneygramProcesId;
  String? moneygramMethodId;
  String? sendAgentId;
  String? remittanceAmount;
  int? remittanceFee;
  String? totalAmount;
  String? exchangeRate;
  String? estimatedReceivingAmount;
  String? receivingCurrencyCode;
  String? csDepositFee;
  String? csDepositAmount;
  String? jpDepositFee;
  String? jpDepositAmount;
  String? rcDepositFee;
  String? rcDepositAmount;
  String? taxType;
  String? baseCurrency;
  String? counterCurrency;
  String? accountBalance;
  String? bonusAmt;
  String? remittanceAmountAfterPromo;
  String? serviceChargeAfterPromo;
  String? freeTxn;
  String? taxAmount;
  bool? processResult;

  factory CalculateTransactionResponse.fromJson(Map<String, dynamic> json) => CalculateTransactionResponse(
        moneygramProcesId: json["moneygram_proces_id"],
        moneygramMethodId: json["moneygram_method_id"],
        sendAgentId: json["send_agent_id"],
        remittanceAmount: json["remittance_amount"],
        remittanceFee: json["remittance_fee"],
        totalAmount: json["total_amount"],
        exchangeRate: json["exchange_rate"],
        estimatedReceivingAmount: json["estimated_receiving_amount"],
        receivingCurrencyCode: json["receiving_currency_code"],
        csDepositFee: json["cs_deposit_fee"],
        csDepositAmount: json["cs_deposit_amount"],
        jpDepositFee: json["jp_deposit_fee"],
        jpDepositAmount: json["jp_deposit_amount"],
        rcDepositFee: json["rc_deposit_fee"],
        rcDepositAmount: json["rc_deposit_amount"],
        baseCurrency: json["base_currency"],
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
}
