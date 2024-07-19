import 'package:fresh_fold_delivery/repository/repository.dart';

import '../../domain/repository/ekyc_repository.dart';

class EkycRepositoryImpl implements EkycRepository {
  EkycRepositoryImpl({required this.networkClient});

  NetworkClient networkClient;

  @override
  Future<Either<Exception, String>> getZlozInitializationToken() async {
    // final requestData = IntitializeZolozTokenRequestModel(
    //   metaInfo: data.metaInfo,
    //   doctype: data.docyType,
    // );

    // final postBody = jsonEncode(requestData.toJson());

    try {
      //final response = await networkClient.post("common/ZolozsInitialize", body: postBody);
      // final response = await networkClient.post("Zoloz/ZolozsInitialize", body: postBody);

      // final zolozResponseModel = InitializeZolozTokenTesponseModel.fromJson(response.asMap!);
      // final zolozInitializationCredential = ZolozInitializationCredential(
      //   clientConfig: zolozResponseModel.data?.clientCfg ?? "",
      //   rsaPublicKey: zolozResponseModel.data?.rsaPubKey ?? "",
      // );
      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> notifyScanCompletion() async {
    try {
      final _ = await networkClient.get("zoloz/ZolozsCheckResult");

      return const Right("Success");
    } on Exception catch (error) {
      return Left(error);
    }
  }
}
