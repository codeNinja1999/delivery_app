import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/data/core/app_service_endpoints.dart';
import 'package:fresh_fold_delivery/repository/data/user/data_store/user_credential_data.dart';
import 'package:fresh_fold_delivery/repository/data/user/models/refresh_token/refresh_token_request_model.dart';
import 'package:fresh_fold_delivery/repository/data/user/models/user_authentication/user_authentication_response_model.dart';
import 'package:fresh_fold_delivery/repository/data/user/repository/mapping/user_authentication_response_mapping.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/authentication/user_access_credential.dart';
import 'package:fresh_fold_delivery/repository/domain/core/failure.dart';
import 'package:fresh_fold_delivery/repository/domain/user/repository/user_authentication_repository.dart';
import 'package:network/network.dart';

class UserAuthenticationRepositoryImpl implements UserAuthenticationRepository {
  UserAuthenticationRepositoryImpl({
    required this.networkClient,
  }) : userCredentialStorage = UserCredentialDataStore();

  NetworkClient networkClient;
  UserCredentialDataStore userCredentialStorage;

  @override
  Future<UserAccessCredential?> userAccessCredential() async {
    return userCredentialStorage.getCredential();
  }

  // @override
  // Future<Either<Exception, UserAccessCredential>> authenticateUser(LoginInfo loginInfo) async {
    // final requestDataModel = loginInfo.toRequestData();
    // final postBody = jsonEncode(requestDataModel.toJson());

    // try {
    //   final response = await networkClient.post(AppServiceEndpoints.login, body: postBody);

    //   final responseModel = UserAuthenticationResponseModel.fromJson(json.decode(response.asString));
    //   if (responseModel.newDeviceFlag == true) {
    //     return Left(NewDeviceDetected(responseModel.deviceVerificationProcessId ?? ""));
    //   } else {
    //     final credential = responseModel.toDomain();
    //     await userCredentialStorage.saveCredential(credential);
    //     return Right(credential);
    //   }
    // } on Exception catch (error) {
    //   return Left(error);
    // }

  // }

  @override
  Future<Either<Exception, UserAccessCredential>> refreshUserToken() async {
    final userCredential = await userCredentialStorage.getCredential();
    final requestDataModel = RefreshTokenRequestModel(
      refreshToken: userCredential?.refreshToken ?? "",
      accessToken: userCredential?.accessToken ?? "",
      grantType: "refresh-token",
    );
    final postBody = jsonEncode(requestDataModel.toJson());

    try {
      final response = await networkClient.post(AppServiceEndpoints.login, body: postBody);

      final responseJson = json.decode(response.asString);
      final credential = UserAuthenticationResponseModel.fromJson(responseJson).toDomain();
      await userCredentialStorage.saveCredential(credential);
      return Right(credential);
    } on Exception catch (error) {
      if (error is SessionExpired) {
        clearCredential();
      }
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> persistUser(String username) async {
    try {
      final _ = await userCredentialStorage.saveUserName(username);
      return const Right("success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String?>> getUser() async {
    try {
      final username = await userCredentialStorage.getUsername();
      return Right(username);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> clearPersistUser() async {
    try {
      final _ = await userCredentialStorage.deleteUser();
      return const Right("success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  void clearCredential() {
    userCredentialStorage.deleteCredential();
  }
}
