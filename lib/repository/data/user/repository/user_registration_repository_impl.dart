import 'package:fresh_fold_delivery/repository/repository.dart';

class UserRegistrationRepositoryImpl implements UserRegistrationRepository {
  UserRegistrationRepositoryImpl({required this.networkClient});

  NetworkClient networkClient;

  @override
  Future<Either<Exception, String>> register() async {
    // final requestData = data.toRequestData();
    // final postBody = jsonEncode(requestData.toJson());

    try {
      // final response = await networkClient.post(AppServiceEndpoints.register, body: postBody);
      // final responseData = UserRegistrationResponseModel.fromJson(response.asMap ?? {});

      return Right("");
    } on Exception catch (error) {
      return Left(error);
    }
  }


}
