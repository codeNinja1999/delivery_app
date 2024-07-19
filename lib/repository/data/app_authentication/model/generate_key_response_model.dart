import 'package:fresh_fold_delivery/repository/domain/app_authentication/entities/app_credential.dart';

class GenerateKeyResponseModel extends AppAccessCredential {
  final bool? splashContinue;
  final String? splashMessage;
  final bool? newVersionAvailable;
  final bool? requireForceUpdate;

  // ignore: use_super_parameters
  GenerateKeyResponseModel({
    required super.processKey,
    this.splashContinue,
    this.splashMessage,
    this.newVersionAvailable,
    this.requireForceUpdate,
    initialLaunch,
  }) : super(initialLaunch: initialLaunch);

  factory GenerateKeyResponseModel.fromJson(Map<String, dynamic> json) => GenerateKeyResponseModel(
        processKey: json["process_key"],
        splashContinue: json["splash_continue"],
        splashMessage: json["splash_message"],
        newVersionAvailable: json["new_version_available"],
        requireForceUpdate: json["require_force_update"],
      );
  GenerateKeyResponseModel copyWith(bool launchStatus) {
    return GenerateKeyResponseModel(
      processKey: processKey,
      splashContinue: splashContinue,
      splashMessage: splashMessage,
      newVersionAvailable: newVersionAvailable,
      requireForceUpdate: requireForceUpdate,
      initialLaunch: launchStatus,
    );
  }
}
