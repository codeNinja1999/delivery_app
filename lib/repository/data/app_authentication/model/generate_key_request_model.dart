class GenerateKeyRequestModel {
  GenerateKeyRequestModel({
    required this.deviceId,
    required this.deviceName,
    required this.deviceOs,
    required this.appVersion,
    this.longitude,
    this.latitude,
    required this.fcmRegistrationId,
  });

  String deviceId;
  String deviceName;
  String deviceOs;
  String appVersion;
  String? longitude;
  String? latitude;
  String fcmRegistrationId;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['device_id'] = deviceId;
    data['device_name'] = deviceName;
    data['device_os'] = deviceOs;
    data['app_version'] = appVersion;
    data['fcm_registration_id'] = fcmRegistrationId;
    return data;
  }
}
