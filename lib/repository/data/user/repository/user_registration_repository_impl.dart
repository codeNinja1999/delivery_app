import 'dart:convert';

import 'package:fresh_fold_delivery/repository/data/core/core.dart';
import 'package:fresh_fold_delivery/repository/data/user/repository/mapping/user_registration_request_mapping.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

import '../models/registration/user_registration_response_model.dart';

class UserRegistrationRepositoryImpl implements UserRegistrationRepository {
  UserRegistrationRepositoryImpl({required this.networkClient});

  NetworkClient networkClient;

  @override
  Future<Either<Exception, String>> register(RegistrationInfo registrationInfo) async {
    final requestData = registrationInfo.toRegisterUser();
    final postBody = jsonEncode(requestData.toJson());

    try {
      final response = await networkClient.patch(AppServiceEndpoints.register, body: postBody);
      final responseData = UserRegistrationResponseModel.fromJson(response.asMap ?? {});

      return Right(responseData.toString());
    } on Exception catch (error) {
      return Left(error);
    }
  }
}
