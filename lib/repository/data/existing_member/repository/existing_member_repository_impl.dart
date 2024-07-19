import 'package:either_dart/either.dart';
import 'package:fresh_fold_delivery/repository/data/existing_member/model/check_existing_member/check_existing_member.dart';
import 'package:fresh_fold_delivery/repository/data/existing_member/repository/mapping/mapping.dart';
import 'package:network/network.dart';
import 'package:fresh_fold_delivery/repository/data/core/app_service_endpoints.dart';
import 'dart:convert';

import '../../../domain/domain.dart';

class ExistingMemberRepositoryImpl implements ExistingMemberRepository {
  ExistingMemberRepositoryImpl({required this.networkClient});

  NetworkClient networkClient;

  @override
  Future<Either<Exception, CheckExistingMemberResult>> checkExistingMember(CheckExistingMemberInfo info) async {
    final requestData = info.toRequest();
    final postBody = jsonEncode(requestData.toJson());
    try {
      final response = await networkClient.post(AppServiceEndpoints.checkExistingMember, body: postBody);
      final responseJson = json.decode(response.asString);
      final responseData = CheckExistingMemberResponseModel.fromJson(responseJson);
      return Right(responseData.toDomain());
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> updateExistingMember(UpdateExistingMemberInfo info) async {
    final requestData = info.toRequest();
    final postBody = jsonEncode(requestData.toJson());

    try {
      final _ = await networkClient.post(AppServiceEndpoints.updateExistingMember, body: postBody);
      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }
}
