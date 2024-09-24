import 'dart:convert';

import 'package:fresh_fold_delivery/repository/data/core/core.dart';
import './mapping/update_operator_request_mapping.dart';
import './mapping/create_operator_request_mapping.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

import '../../../domain/operator/entities/operator_entities.dart';
import '../../../domain/operator/repository/operator_repository.dart';

class OperatorRepositoryImpl implements OperatorRepository {
  OperatorRepositoryImpl({required this.networkClient});

  NetworkClient networkClient;

  @override
  Future<Either<Exception, String>> addOperator(Operator operatorInfo) async {
    final requestData = operatorInfo.toCreateOperator();
    final postBody = jsonEncode(requestData.toJson());

    try {
      final _ = await networkClient.patch(AppServiceEndpoints.register, body: postBody);
      // final responseData = UserRegistrationResponseModel.fromJson(response.asMap ?? {});

      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> updateOperator(Operator operatorInfo) async {
    final requestData = operatorInfo.toUpdateOperator();
    final postBody = jsonEncode(requestData.toJson());

    try {
      final _ = await networkClient.patch(AppServiceEndpoints.register, body: postBody);
      // final responseData = UserRegistrationResponseModel.fromJson(response.asMap ?? {});

      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> deleteOperator(String operatorId) async {
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
}
