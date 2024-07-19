import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_fold_delivery/repository/data/user/data_store/entities/user_cedential_data.dart';
import 'package:fresh_fold_delivery/repository/data/core/store_constants.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/authentication/user_access_credential.dart';

class UserCredentialDataStore {
  final storage = const FlutterSecureStorage();
  IOSOptions _getIOSOptions() => const IOSOptions(
        accountName: StoreConstants.accountName,
      );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(encryptedSharedPreferences: true, resetOnError: true);

  saveCredential(UserAccessCredential credential) async {
    final credntialData = UserCredentialData.fromCredential(data: credential);
    final credentialDataJson = jsonEncode(credntialData.toJson()).toString();

    await storage.write(
        key: StoreConstants.userCredential,
        value: credentialDataJson,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions());
  }

  Future<UserAccessCredential?> getCredential() async {
    // final prefs = await SharedPreferences.getInstance();
    // final flag = prefs.getBool('first_run') ?? true;
    // if (flag) {
    //   await storage.deleteAll();

    //   prefs.setBool('first_run', false);
    // }

    final data =
        await storage.read(iOptions: _getIOSOptions(), aOptions: _getAndroidOptions(), key: StoreConstants.userCredential);
    if (data != null) {
      final credentialJosn = json.decode(data);
      final credential = UserCredentialData.fromJson(credentialJosn);
      return UserAccessCredential(
          clientId: credential.clientId,
          username: credential.username,
          firstTimeLogin: credential.firstTimeLogin,
          lastLoginTs: credential.lastLoginTs,
          accessToken: credential.accessToken,
          tokenType: credential.tokenType,
          expiresIn: credential.expiresIn,
          refreshToken: credential.refreshToken,
          expires: credential.expires,
          issued: credential.issued);
    } else {
      return null;
    }
  }

  saveUserName(String username) async {
    await storage.write(
        key: StoreConstants.username, value: username, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }

  Future<String?> getUsername() async {
    final data =
        await storage.read(iOptions: _getIOSOptions(), aOptions: _getAndroidOptions(), key: StoreConstants.username);
    return data;
  }

  deleteUser() async {
    await storage.delete(key: StoreConstants.username, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }

  deleteCredential() async {
    await storage.delete(key: StoreConstants.userCredential, iOptions: _getIOSOptions(), aOptions: _getAndroidOptions());
  }
}
