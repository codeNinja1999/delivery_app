// To parse this JSON data, do
//
//     final confirmTransactionRequest = confirmTransactionRequestFromJson(jsonString);

import 'dart:convert';

ConfirmTransactionRequest confirmTransactionRequestFromJson(String str) =>
    ConfirmTransactionRequest.fromJson(json.decode(str));

String confirmTransactionRequestToJson(ConfirmTransactionRequest data) => json.encode(data.toJson());

class ConfirmTransactionRequest {
  ConfirmTransactionRequest({
    this.tran,
    this.tradePassword,
  });

  String? tran;
  String? tradePassword;

  factory ConfirmTransactionRequest.fromJson(Map<String, dynamic> json) => ConfirmTransactionRequest(
        tran: json["tranno"],
        tradePassword: json["trade_password"],
      );

  Map<String, dynamic> toJson() => {
        "tranno": tran,
        "trade_password": tradePassword,
      };
}
