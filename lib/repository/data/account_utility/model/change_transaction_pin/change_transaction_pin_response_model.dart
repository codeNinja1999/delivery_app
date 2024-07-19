

import 'dart:convert';


ChangeTransactionPinResponseModel changeTransactionPinResponseModelFromJson(String str) =>
    ChangeTransactionPinResponseModel.fromJson(json.decode(str));

String changeTransactionPinResponseModelToJson(ChangeTransactionPinResponseModel data) =>
    json.encode(data.toJson());

class ChangeTransactionPinResponseModel {
  ChangeTransactionPinResponseModel({
    this.processResult,
    this.warningList,
  
  });

  bool? processResult;
  List<dynamic>? warningList;

  factory ChangeTransactionPinResponseModel.fromJson(Map<String, dynamic> json) =>
      ChangeTransactionPinResponseModel(
        processResult: json["process_result"],
        warningList: List<dynamic>.from(json["warning_list"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "process_result": processResult,
        "warning_list": List<dynamic>.from(warningList!.map((x) => x)),
      };
}
