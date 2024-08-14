

import 'dart:convert';


// ignore: non_constant_identifier_names
ResetPasswordResponseModel ResetPasswordResponseModelFromJson(String str) =>
    ResetPasswordResponseModel.fromJson(json.decode(str));

// ignore: non_constant_identifier_names
String ResetPasswordResponseModelToJson(ResetPasswordResponseModel data) =>
    json.encode(data.toJson());

class ResetPasswordResponseModel {
  ResetPasswordResponseModel({
    this.processResult,
    this.warningList,
  
  });

  bool? processResult;
  List<dynamic>? warningList;

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ResetPasswordResponseModel(
        processResult: json["process_result"],
        warningList: List<dynamic>.from(json["warning_list"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "process_result": processResult,
        "warning_list": List<dynamic>.from(warningList!.map((x) => x)),
      };
}
