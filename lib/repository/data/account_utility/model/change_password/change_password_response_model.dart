

import 'dart:convert';


ChangePasswordResponseModel changePasswordResponseModelFromJson(String str) =>
    ChangePasswordResponseModel.fromJson(json.decode(str));

String changePasswordResponseModelToJson(ChangePasswordResponseModel data) =>
    json.encode(data.toJson());

class ChangePasswordResponseModel {
  ChangePasswordResponseModel({
    this.processResult,
    this.warningList,
  
  });

  bool? processResult;
  List<dynamic>? warningList;

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponseModel(
        processResult: json["process_result"],
        warningList: List<dynamic>.from(json["warning_list"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "process_result": processResult,
        "warning_list": List<dynamic>.from(warningList!.map((x) => x)),
      };
}
