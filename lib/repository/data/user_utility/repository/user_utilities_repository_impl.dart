import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/data/core/app_service_endpoints.dart';
import 'package:fresh_fold_delivery/repository/data/user/data_store/user_credential_data.dart';
import 'package:fresh_fold_delivery/repository/data/user_utility/mapping/notifications_data_response_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/user_utility/model/notifications/notifications_response_model.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/notification/notification_data.dart';
import 'package:network/network.dart';
import 'package:fresh_fold_delivery/repository/domain/user/repository/user_utility_repository.dart';
import 'package:rxdart/subjects.dart';
import 'dart:async';

class UserUtilitiesRepositoryImpl implements UserUtilitiesRepository {
  UserUtilitiesRepositoryImpl({required this.networkClient});

  NetworkClient networkClient;

  final _userInfoStreamController = BehaviorSubject<DetailedUser?>.seeded(null);

  @override
  clearSavedUser() {
    throw UnimplementedError();
  }

  // @override
  // Future<String> getUserInfo() async {
  //   try {
  //     final reponse = await networkClient.get(AppServiceEndpoints.getUserInfo);
  //     final responseJson = json.decode(reponse.asString);
  //     final getuserinfoResponse = GetuserinfoResponseModel.fromJson(responseJson);
  //     if (getuserinfoResponse.memberInfo != null) {
  //       _userInfoStreamController.add(getuserinfoResponse.memberInfo?.toDomain());
  //     } else {
  //       _userInfoStreamController.addError(Exception("Data not found"));
  //     }
  //     return "";
  //   } on Exception catch (error) {
  //     _userInfoStreamController.addError(error);
  //     return "error";
  //   }
  // }

  @override
  Stream<DetailedUser?> userInfo() => _userInfoStreamController.asBroadcastStream();

  @override
  Future<Either<Exception, List<NotificationData>>> getUserNotification() async {
    try {
      final response = await networkClient.get(AppServiceEndpoints.notification);
      var responseJson = json.decode(response.asString);
      var notificationResponse = NotificationResponseModel.fromJson(responseJson);
      if (notificationResponse.resultList != null) {
        final List<NotificationData> notificationList = notificationResponse.resultList!.map((e) => e.toDomain()).toList();
        return Right(notificationList);
      } else {
        return Left(Exception("Data not found"));
      }
    } on Exception catch (error) {
      return Left(error);
    }
  }

  // @override
  // Future<Either<Exception, DetailedUser>> updateUserInfo(UserUpdateInfo data) async {
  //   final requestData = data.toRequestData();
  //   final postBody = requestData.toJson();

  //   try {
  //     final reponse = await networkClient.post(AppServiceEndpoints.updateMember, body: postBody);
  //     var responseJson = json.decode(reponse.asString);
  //     var userupdateResponse = UserupdateinfoResponseModel.fromJson(responseJson);
  //     if (userupdateResponse.memberInfo != null) {
  //       return Right(userupdateResponse.memberInfo!.toDomain());
  //     } else {
  //       return Left(Exception("Data not found"));
  //     }
  //   } on Exception catch (error) {
  //     return Left(error);
  //   }
  // }

  @override
  Future<Either<Exception, String>> logoutUser() async {
    try {
      final _ = await networkClient.post(AppServiceEndpoints.logoutUser);
      final userCredentialStorage = UserCredentialDataStore();
      userCredentialStorage.deleteCredential();
      return const Right('success');
    } on Exception catch (error) {
      final userCredentialStorage = UserCredentialDataStore();
      userCredentialStorage.deleteCredential();
      return Left(error);
    }
  }
}
