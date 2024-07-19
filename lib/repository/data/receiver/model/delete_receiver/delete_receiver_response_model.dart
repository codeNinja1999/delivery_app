import 'dart:convert';

DeleteReceiverResponse deleteReceiverResponseFromJson(String str) =>
    DeleteReceiverResponse.fromJson(json.decode(str));

String deleteReceiverResponseToJson(DeleteReceiverResponse data) =>
    json.encode(data.toJson());

class DeleteReceiverResponse {
  DeleteReceiverResponse({
    this.processResult,
    this.warningList,
    this.errorList,
  });

  bool? processResult;
  List<DeleteReceiverWarningList>? warningList;
  List<DeleteReceiverErrorList>? errorList;

  factory DeleteReceiverResponse.fromJson(Map<String, dynamic> json) =>
      DeleteReceiverResponse(
        processResult: json["process_result"],
        warningList: List<DeleteReceiverWarningList>.from(
            json["warning_list"].map((x) => DeleteReceiverWarningList.fromJson(x))),
        errorList: List<DeleteReceiverErrorList>.from(
            json["error_list"].map((x) => DeleteReceiverErrorList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "process_result": processResult,
        "warning_list": List<dynamic>.from(warningList!.map((x) => x.toJson())),
        "error_list": List<dynamic>.from(errorList!.map((x) => x.toJson())),
      };
}

class DeleteReceiverErrorList {
  DeleteReceiverErrorList({
    this.errorCode,
    this.errorMessage,
  });

  String? errorCode;
  String? errorMessage;

  factory DeleteReceiverErrorList.fromJson(Map<String, dynamic> json) => DeleteReceiverErrorList(
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "error_message": errorMessage,
      };
}

class DeleteReceiverWarningList {
  DeleteReceiverWarningList({
    this.warningCode,
    this.warningMessage,
  });

  String? warningCode;
  String? warningMessage;

  factory DeleteReceiverWarningList.fromJson(Map<String, dynamic> json) => DeleteReceiverWarningList(
        warningCode: json["warning_code"],
        warningMessage: json["warning_message"],
      );

  Map<String, dynamic> toJson() => {
        "warning_code": warningCode,
        "warning_message": warningMessage,
      };
}
