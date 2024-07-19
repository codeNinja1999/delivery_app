
import 'dart:convert';

ChangeTransactionPinRequestModel changeTransactionPinRequestModelFromJson(String str) =>
    ChangeTransactionPinRequestModel.fromJson(json.decode(str));

String changeTransactionPinRequestModelToJson(ChangeTransactionPinRequestModel data) =>
    json.encode(data.toJson());

class ChangeTransactionPinRequestModel {
  ChangeTransactionPinRequestModel({
    this.currentPin,
    this.newPin,
    this.useAsLoginPassword,
    this.issueType,
    this.processId,
  });

  String? currentPin;
  String? newPin;
  String? useAsLoginPassword;
  String? issueType;
  String? processId;

  factory ChangeTransactionPinRequestModel.fromJson(Map<String, dynamic> json) =>
      ChangeTransactionPinRequestModel(
        currentPin: json["current_pin"],
        newPin: json["new_pin"],
        useAsLoginPassword: json["user_as_login_password"],
        issueType: json["issue_type"],
        processId: json["process_id"],
      );

  Map<String, dynamic> toJson() => {
        "current_pin": currentPin,
        "new_pin": newPin,
        "user_as_login_password": useAsLoginPassword,
        "issue_type": issueType,
        "process_id": processId,
      };
}
