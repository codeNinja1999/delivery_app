class UploadDocumentResponseModel {
  bool processResult;
  dynamic imgUrlList;
  dynamic fileName;
  dynamic code;
  dynamic message;
  List<dynamic> warningList;
  List<dynamic> errorList;

  UploadDocumentResponseModel({
    required this.processResult,
    required this.imgUrlList,
    required this.fileName,
    required this.code,
    required this.message,
    required this.warningList,
    required this.errorList,
  });

  factory UploadDocumentResponseModel.fromJson(Map<String, dynamic> json) => UploadDocumentResponseModel(
        processResult: json["process_result"],
        imgUrlList: json["imgUrlList"],
        fileName: json["file_name"],
        code: json["code"],
        message: json["message"],
        warningList: List<dynamic>.from(json["warning_list"].map((x) => x)),
        errorList: List<dynamic>.from(json["error_list"].map((x) => x)),
      );
}
