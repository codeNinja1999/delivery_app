T? tryCast<T>(dynamic object) => object is T ? object : null;

class ErrorDecodable {
  ErrorDecodable({
    this.processResult,
    this.errorDescription,
    this.errorList,
  });

  bool? processResult;
  String? errorDescription;

  List<ErrorDecodableErrorList>? errorList;

  factory ErrorDecodable.fromJson(Map<String, dynamic> json) => ErrorDecodable(
        processResult: (tryCast<bool>(json["process_result"])),
        errorDescription: json["error_description"],
        errorList: json["error_list"] == null
            ? null
            : List<ErrorDecodableErrorList>.from(
                json["error_list"].map((x) => ErrorDecodableErrorList.fromJson(x))),
      );
}

class ErrorDecodableErrorList {
  ErrorDecodableErrorList({
    this.errorCode,
    this.errorMessage,
  });

  String? errorCode;

  String? errorMessage;

  factory ErrorDecodableErrorList.fromJson(Map<String, dynamic> json) => ErrorDecodableErrorList(
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
      );
}
