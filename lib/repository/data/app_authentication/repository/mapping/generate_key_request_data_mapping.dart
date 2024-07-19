import 'package:fresh_fold_delivery/repository/data/app_authentication/model/generate_key_request_model.dart';
import 'package:fresh_fold_delivery/repository/domain/app_authentication/entities/app_info.dart';

extension GenerateKeyRequestDataMapping on AppInfo {
  GenerateKeyRequestModel toRequestData() {
    final requestData = GenerateKeyRequestModel(
      deviceId: deviceID,
      deviceName: deviceName,
      deviceOs: deviceOS,
      appVersion: appVersion,
      fcmRegistrationId: fcmRegistrationID,
    );
    return requestData;
  }
}
