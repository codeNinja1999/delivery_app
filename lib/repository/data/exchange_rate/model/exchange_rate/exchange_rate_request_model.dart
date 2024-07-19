class ExchangeRateRequestModel {
  ExchangeRateRequestModel(
      {this.customerId,
      this.beneficiaryCountryCode,
      this.receiveCurrencyCode,
      this.remittanceMethodCode,
      this.remittanceAmountMethodCode,
      this.remittanceAmount,
      this.includeFee});
  String? customerId;
  String? beneficiaryCountryCode;
  String? receiveCurrencyCode;
  String? remittanceMethodCode;
  String? remittanceAmountMethodCode;
  String? remittanceAmount;
  bool? includeFee;

  factory ExchangeRateRequestModel.fromJson(Map<String, dynamic> json) =>
      ExchangeRateRequestModel(
        customerId: json["customer_id"],
        beneficiaryCountryCode: json["beneficiary_country_code"],
        receiveCurrencyCode: json["receive_currency_code"],
        remittanceMethodCode: json["remittance_method_code"],
        remittanceAmountMethodCode: json["remittance_amount_method_code"],
        remittanceAmount: json["remittance_amount"],
        includeFee: json["include_fee"],
      );

  Map<String, dynamic> toJson() => {
        "customer_id": customerId,
        "beneficiary_country_code": beneficiaryCountryCode,
        "receive_currency_code": receiveCurrencyCode,
        "remittance_method_code": remittanceMethodCode,
        "remittance_amount_method_code": remittanceAmountMethodCode,
        "remittance_amount": remittanceAmount,
        "include_fee": includeFee,
      };
}
