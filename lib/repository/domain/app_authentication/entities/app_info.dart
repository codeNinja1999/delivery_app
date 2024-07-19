import 'package:fresh_fold_delivery/repository/domain/core/coordinate.dart';

class AppInfo {
  AppInfo(
      {required this.deviceID,
      required this.deviceName,
      required this.deviceOS,
      required this.appVersion,
      required this.fcmRegistrationID,
      this.coordinate});
  final String deviceID;
  final String deviceName;
  final String deviceOS;
  final String appVersion;
  final String fcmRegistrationID;
  final Coordinate? coordinate;
}
