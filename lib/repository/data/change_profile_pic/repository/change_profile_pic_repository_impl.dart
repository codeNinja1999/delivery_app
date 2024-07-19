import 'package:fresh_fold_delivery/repository/repository.dart';

class ChangeProfilePicRepositoryImpl implements ChangeProfilePicRepository {
  ChangeProfilePicRepositoryImpl({required this.networkClient});
  NetworkClient networkClient;

  @override
  Future<Either<Exception, ChangeProfilePicList>> changeProfilePic(ChangeProfilePicInfo picData) async {
    final requestData = picData.toRequestData();
    final requestFormData = await requestData.toJson().toMultipartFile();
    try {
      final response = await networkClient.post(
        AppServiceEndpoints.changeProfileImage,
        body: requestFormData,
      );
      final responseData = ChangeProfileResponse.fromJson(response.asMap ?? {});
      return Right(responseData.toDomain());
    } on Exception catch (error) {
      return Left(error);
    }
  }
}
