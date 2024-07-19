class CalculateTransactionRequest {
  CalculateTransactionRequest({
    this.beneficiaryId,
    this.beneficiaryCountryCode,
    this.sendCurrencyCode,
    this.receiveCurrencyCode,
    this.depositMethodCode,
    this.remittanceMethodCode,
    this.remittanceAmountMethodCode,
    this.includeFee,
    this.remittanceAmount,
    this.promoCode,
  });

  String? beneficiaryId;
  String? beneficiaryCountryCode;
  String? sendCurrencyCode;
  String? receiveCurrencyCode;
  String? depositMethodCode;
  String? remittanceMethodCode;
  String? remittanceAmountMethodCode;
  bool? includeFee;
  String? remittanceAmount;
  String? promoCode;

  factory CalculateTransactionRequest.fromJson(Map<String, dynamic> json) =>
      CalculateTransactionRequest(
        beneficiaryId: json["beneficiary_id"],
        beneficiaryCountryCode: json["beneficiary_country_code"],
        sendCurrencyCode: json["send_currency_code"],
        receiveCurrencyCode: json["receive_currency_code"],
        depositMethodCode: json["deposit_method_code"],
        remittanceMethodCode: json["remittance_method_code"],
        remittanceAmountMethodCode: json["remittance_amount_method_code"],
        includeFee: json["include_fee"],
        remittanceAmount: json["remittance_amount"],
        promoCode: json["promo_code"],
      );

  Map<String, dynamic> toJson() => {
        "beneficiary_id": beneficiaryId,
        "beneficiary_country_code": beneficiaryCountryCode,
        "send_currency_code": sendCurrencyCode,
        "receive_currency_code": receiveCurrencyCode,
        "deposit_method_code": depositMethodCode,
        "remittance_method_code": remittanceMethodCode,
        "remittance_amount_method_code": remittanceAmountMethodCode,
        "include_fee": includeFee,
        "remittance_amount": remittanceAmount,
        "promo_code": promoCode,
      };
}
