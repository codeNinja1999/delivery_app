import 'dart:async';

import 'dart:convert';
import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/data/core/core.dart';
import 'package:fresh_fold_delivery/repository/data/user/data_store/user_credential_data.dart';
import 'package:fresh_fold_delivery/repository/data/user_utility/mapping/create_laundry_request.dart';
import 'package:fresh_fold_delivery/repository/data/user_utility/mapping/update_user_profile_request_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/user_utility/mapping/user_utility_data_mapping.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/notification/notification_data.dart';
import 'package:fresh_fold_delivery/repository/domain/user/repository/user_utility_repository.dart';
import 'package:network/network.dart';
import 'package:rxdart/subjects.dart';

import '../../../domain/operator/entities/operator_entities.dart';
import '../../../domain/pickup_order/pickup_order.dart';
import '../model/get_userinfo/get_userinfo_reponse_model.dart';
import '../mapping/user_list_mapping.dart';

class UserUtilitiesRepositoryImpl implements UserUtilitiesRepository {
  UserUtilitiesRepositoryImpl({required this.networkClient});

  NetworkClient networkClient;

  final _userInfoStreamController = BehaviorSubject<DetailedUser?>.seeded(null);

  @override
  clearSavedUser() {
    throw UnimplementedError();
  }

  @override
  Future<String> getUserInfo() async {
    try {
      final response = await networkClient.get(AppServiceEndpoints.getDetail);
      final responseJson = json.decode(response.asString);
      final responseModel = GetUserInfoResponseModel.fromJson(responseJson);
      if (responseModel.userId != null) {
        _userInfoStreamController.add(responseModel.toUserInfoDomain());
      } else {
        _userInfoStreamController.addError(Exception("Data not found"));
      }
      return "";
    } on Exception catch (error) {
      _userInfoStreamController.addError(error);
      return "error";
    }
  }

  @override
  Stream<DetailedUser?> userInfo() => _userInfoStreamController.asBroadcastStream();

  @override
  Future<Either<Exception, List<NotificationData>>> getUserNotification() async {
    try {
      final response = await networkClient.get(AppServiceEndpoints.createLocation);
      var _ = json.decode(response.asString);
      return Right([NotificationData()]);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> createOrder(PickupOrder data) async {
    final requestData = data.toCreateOrderRequest();
    final postBody = requestData.toJson().toMultipartFile();
    try {
      final response = await networkClient.post(AppServiceEndpoints.createPickupRequest, body: postBody);
      var _ = json.decode(response.asString);
      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> updateUserProfile(User data) async {
    final requestData = data.toUpdateUserProfile();
    final postBody = jsonEncode(requestData.toJson());

    try {
      final _ = await networkClient.post(AppServiceEndpoints.updateUserProfile, body: postBody);
      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, List<DetailedUser>>> getUserList() async {
    try {
      final response = await networkClient.get(AppServiceEndpoints.getAllUser);
      final List<dynamic> responseJson = json.decode(response.asString);
      final userList = responseJson.map((user) => UserMapper.fromJson(user)).toList();
      return Right(userList);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, List<DetailedOperator>>> getOperatorList() async {
    try {
      final response = await networkClient.post(AppServiceEndpoints.getAllOperator);
      final List<dynamic> responseJson = json.decode(response.asString);
      final operatorList = responseJson.map((user) => UserMapper.fromJsonList(user)).toList();
      return Right(operatorList);
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
      final _ = await networkClient.post(AppServiceEndpoints.logout);
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
