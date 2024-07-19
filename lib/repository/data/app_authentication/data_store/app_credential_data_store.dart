import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_fold_delivery/repository/data/app_authentication/data_store/entities/app_credential_data.dart';
import 'package:fresh_fold_delivery/repository/domain/app_authentication/entities/app_credential.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/store_constants.dart';

class AppCredentialDataStore {
  final storage = const FlutterSecureStorage();
  IOSOptions _getIOSOptions() => const IOSOptions(
        accountName: StoreConstants.accountName,
      );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(encryptedSharedPreferences: true, resetOnError: true);
  AndroidOptions _getAndroidOptionsForGet() => const AndroidOptions(encryptedSharedPreferences: true);

  Future<bool> getAppLaunchStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(StoreConstants.launchStatus) == null;
  }

  setAppLaunchStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(StoreConstants.launchStatus, false);
  }

  getProcessID(String key) async {
    final data = await storage.read(iOptions: _getIOSOptions(), aOptions: _getAndroidOptions(), key: key);
    return data;
  }

  saveCredential(AppCredentialData credential) async {
    final credntialData = jsonEncode(credential.toJson()).toString();
    await storage.write(
        key: StoreConstants.processKey, value: credntialData, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }

  Future<AppAccessCredential> getCredential() async {
    final data =
        await storage.read(iOptions: _getIOSOptions(), aOptions: _getAndroidOptionsForGet(), key: StoreConstants.processKey);
    var credentialJosn = json.decode(data ?? "");
    final credential = AppCredentialData.fromJson(credentialJosn);
    return AppAccessCredential(processKey: credential.processKey);
  }
}
