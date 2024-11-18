import 'dart:convert';
import 'dart:core';

import 'package:fresh_fold_delivery/repository/data/user/repository/mapping/user_registration_request_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/user_utility/mapping/order_history_data_mapping.dart';
import 'package:network/network.dart';
import 'package:rxdart/subjects.dart';
import 'package:either_dart/either.dart';

import 'package:fresh_fold_delivery/repository/data/core/core.dart';
import '../../../data/user_utility/mapping/analytics_data_mapping.dart';
import '../../../data/user_utility/mapping/create_laundry_request.dart';
import '../../../data/user_utility/mapping/update_user_profile_request_mapping.dart';
import '../../../data/user_utility/mapping/user_utility_data_mapping.dart';
import '../../../domain/common/model/date_filter.dart';
import '../../../domain/common/model/pagination_filter.dart';
import '../../../domain/pickup_order/pickup_order.dart';
import '../../../domain/pickup_order/pickup_order_result.dart';
import '../../../domain/user/entities/analytic_data_info.dart';
import '../../../domain/user/entities/notification/notification_data.dart';
import '../../../domain/user/entities/registration/operator_registration_info.dart';
import '../../../domain/user/entities/user_info/user.dart';
import '../../../domain/user/repository/user_utility_repository.dart';
import '../../user/data_store/user_credential_data.dart';
import '../mapping/operator_list_mapping.dart';
import '../model/analytics_data_response_model.dart';
import '../model/get_userinfo/get_userinfo_reponse_model.dart';
import '../mapping/user_list_mapping.dart';
import '../model/pickup_order_response_model.dart';

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
      final response = await networkClient.get(AppServiceEndpoints.getDetails);
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
  // @override
  // Future<String> getUserInfo() async {
  //   try {
  //     final response = await networkClient.get(AppServiceEndpoints.getUserInfo);
  //     final responseJson = json.decode(response.asString);
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
    final requestFormData = await requestData.toJson().toMultipartFile();
    try {
      // final response = await networkClient.post(AppServiceEndpoints.createPickupRequest, body: postBody);
      final response = await networkClient.send(
        AppServiceEndpoints.createPickupRequest,
        method: HttpMethod.post,
        body: requestFormData,
      );
      final _ = json.decode(response.asString);
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
  Future<Either<Exception, List<DetailedUser>>> getUserList(PaginationFilter filter) async {
    final query = {
      "page": filter.page,
      "pageSize": filter.pageSize,
    };

    try {
      final response = await networkClient.get(AppServiceEndpoints.getAllUser, queryParameters: query);
      final List<dynamic> responseJson = json.decode(response.asString);
      final userList = responseJson.map((user) => UserMapper.fromJson(user)).toList();
      return Right(userList);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, List<PickupOrderResult>>> getOrderHistory(PaginationFilter filter) async {
    final query = {
      "status": "pending",
      "page": filter.page,
      "pageSize": filter.pageSize,
    };

    try {
      final response = await networkClient.get(AppServiceEndpoints.getAllOrder, queryParameters: query);
      final List<dynamic> responseJson = json.decode(response.asString);
      final historyModel = responseJson.map((orderHistory) => PickupOrderResponseModel.fromJson(orderHistory)).toList();
      final List<PickupOrderResult> pickupOrderHistory = historyModel.map((model) => model.toOrderHistory()).toList();
      return Right(pickupOrderHistory);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, AnalyticDataInfo>> fetchAnalyticData(DateFilter filter) async {
    final query = {
      "from": filter.from,
      "to": filter.to,
    };

    try {
      final response = await networkClient.get(AppServiceEndpoints.getAnalyticsData, queryParameters: query);
      final responseJson = json.decode(response.asString);
      final analyticModel = AnalyticsDataResponseModel.fromJson(responseJson);
      final analyticData = analyticModel.toAnalyticData();
      return Right(analyticData);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  // @override
  // Future<Either<Exception, DetailedUser>> updateUserInfo(UserUpdateInfo data) async {
  //   final requestData = data.toRequestData();
  //   final postBody = requestData.toJson();

  //   try {
  //     final _ = await networkClient.post(AppServiceEndpoints.updateUserProfile, body: postBody);
  //     return const Right("Success");
  //   } on Exception catch (error) {
  //     return Left(error);
  //   }
  @override
  Future<Either<Exception, List<DetailedUser>>> getOperatorList(PaginationFilter filter) async {
    final query = {
      "page": filter.page,
      "pageSize": filter.pageSize,
    };

    try {
      final response = await networkClient.get(AppServiceEndpoints.getAllOperator, queryParameters: query);
      final List<dynamic> responseJson = json.decode(response.asString);
      final operatorList = responseJson.map((operator) => OperatorListMapper.fromJsonList(operator)).toList();
      return Right(operatorList);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> updateOperator(OperatorRegistrationInfo operatorInfo) async {
    final requestData = operatorInfo.toRegisterOperator();
    final postBody = jsonEncode(requestData.toJson());

    try {
      final _ = await networkClient.patch(AppServiceEndpoints.registerOperator, body: postBody);
      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> deleteOperator(DetailedUser detailedUser) async {
    // final requestData = registrationInfo.toRegisterUser();
    // final postBody = jsonEncode(requestData.toJson());

    try {
      // final _ = await networkClient.patch(AppServiceEndpoints.register, queryParameters: );
      // final responseData = UserRegistrationResponseModel.fromJson(response.asMap ?? {});

      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

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
