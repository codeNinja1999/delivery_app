import 'package:flutter/services.dart';

import 'prod_config.dart';
import 'uat_config.dart';

enum AppFlavour { production, uat }

AppConfig _getAppConfig(String version) => (appFlavor?.toLowerCase() == "prod")
    ? productionConfig(version)
    : uatConfig(version);

class AppConfig {
  final AppFlavour flavor;
  final String baseUrl;
  final String imageBaseUlr;
  final String appKey;
  final String version;

  AppConfig({
    required this.flavor,
    required this.baseUrl,
    required this.imageBaseUlr,
    required this.appKey,
    required this.version,
  });

  static AppConfig shared = AppConfig.initialize();

  factory AppConfig.initialize({String? version}) {
    if (version == null) {
      throw Exception("Warning!! Version should be provided explicitly");
    }
    return shared = _getAppConfig(version);
  }
}
