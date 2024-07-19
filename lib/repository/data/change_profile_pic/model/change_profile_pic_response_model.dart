class ChangeProfileResponse {
  bool? processResult;
  dynamic imgUrlList;
  String? fileName;
  dynamic code;
  dynamic message;
  List<dynamic>? warningList;
  List<dynamic>? errorList;

  ChangeProfileResponse({
    this.processResult,
    this.imgUrlList,
    this.fileName,
    this.code,
    this.message,
    this.warningList,
    this.errorList,
  });

  factory ChangeProfileResponse.fromJson(Map<String, dynamic> json) => ChangeProfileResponse(
        processResult: json["process_result"],
        imgUrlList: json["imgUrlList"],
        fileName: json["file_name"],
        code: json["code"],
        message: json["message"],
        warningList: List<dynamic>.from(json["warning_list"].map((x) => x)),
        errorList: List<dynamic>.from(json["error_list"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "process_result": processResult,
        "imgUrlList": imgUrlList,
        "file_name": fileName,
        "code": code,
        "message": message,
        "warning_list": List<dynamic>.from(warningList!.map((x) => x)),
        "error_list": List<dynamic>.from(errorList!.map((x) => x)),
      };
}
