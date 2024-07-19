import 'dart:convert';

CancelTransactionRequest cancelTransactionRequestFromJson(String str) =>
    CancelTransactionRequest.fromJson(json.decode(str));

String cancelTransactionRequestToJson(CancelTransactionRequest data) =>
    json.encode(data.toJson());

class CancelTransactionRequest {
  CancelTransactionRequest({
    this.tranno,
  });

  String? tranno;

  factory CancelTransactionRequest.fromJson(Map<String, dynamic> json) =>
      CancelTransactionRequest(
        tranno: json["tranno"],
      );

  Map<String, dynamic> toJson() => {
        "tranno": tranno,
      };
}
