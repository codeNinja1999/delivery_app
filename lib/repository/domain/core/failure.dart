class Failure implements Exception {
  final String message;

  Failure(this.message);

  @override
  String toString() {
    return message;
  }
}

class MultipleDeviceDetection implements Exception {
  final String message;

  MultipleDeviceDetection(this.message);

  @override
  String toString() {
    return message;
  }
}

class SessionExpired implements Exception {
  final String message;

  SessionExpired(this.message);

  @override
  String toString() {
    return message;
  }
}

class NewDeviceDetected implements Failure {
  @override
  final String message;

  NewDeviceDetected(this.message);

  @override
  String toString() {
    return message;
  }
}

class NewUpdateAvailable implements Failure {
  bool needForceUpdate;

  @override
  final String message;

  NewUpdateAvailable({required this.message, required this.needForceUpdate});

  @override
  String toString() {
    return message;
  }
}

class UnderMaintenance implements Failure {
  @override
  final String message;

  UnderMaintenance(this.message);

  @override
  String toString() {
    return message;
  }
}

class NoInternetConnection implements Exception {
  final String message;

  NoInternetConnection(this.message);

  @override
  String toString() {
    return message;
  }
}
