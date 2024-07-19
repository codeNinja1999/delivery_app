extension ExceptionExtension on Exception {
  String get exceptionMessage => getMessage();

  String getMessage() {
    final exceptionMessage = toString();

    if (exceptionMessage.contains("Exception")) {
      if (exceptionMessage == "Exception") {
        return "Something went wrong. Contact customer support.";
      } else {
        return exceptionMessage.toString().substring(11);
      }
    } else {
      return exceptionMessage;
    }
  }
}
