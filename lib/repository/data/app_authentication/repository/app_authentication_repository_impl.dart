import 'package:fresh_fold_delivery/repository/repository.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class AppAuthenticationRepositoryImpl implements AppAuthenticationRepository {
  AppAuthenticationRepositoryImpl({
    required this.networkClient,
  });

  final appCredentialStorage = AppCredentialDataStore();
  NetworkClient networkClient;

  @override
  Future<Either<Exception, AppAccessCredential>> generateKey(AppInfo appInfo, String appKey) async {
    final requestData = appInfo.toRequestData();

    final timeStamp = Uri.encodeComponent('${DateTime.now().millisecondsSinceEpoch ~/ 1000}');

    final postBody = jsonEncode(requestData.toJson());
    final signatureValue = "$timeStamp.$postBody.$appKey";
    final signatureValueInBytes = utf8.encode(signatureValue);

    final signature = sha256.convert(signatureValueInBytes).toString();
    final splitSignature = "$timeStamp.$signature";

    final header = <String, String>{};
    header["split-signature"] = splitSignature;

    try {
      final response = await networkClient.post(AppServiceEndpoints.generateKey, headers: header, body: postBody);
      final generateKeyResponseModel = GenerateKeyResponseModel.fromJson(response.asMap ?? {});

      if (generateKeyResponseModel.splashContinue ?? false) {
        final basicToken =
            'Basic ${base64Encode(utf8.encode('${appInfo.deviceID}:${generateKeyResponseModel.processKey}'))}';
        await appCredentialStorage.saveCredential(AppCredentialData(basicToken));

        if (generateKeyResponseModel.newVersionAvailable ?? false) {
          return Left(
            NewUpdateAvailable(
              message: generateKeyResponseModel.splashMessage ??
                  "we added lots of new Features and fix some bugs to make your experience as smooth as possible",
              needForceUpdate: generateKeyResponseModel.requireForceUpdate ?? false,
            ),
          );
        } else {
          final appLaunchStatus = await appCredentialStorage.getAppLaunchStatus();
          final credential = generateKeyResponseModel.copyWith(appLaunchStatus);
          return Right(credential);
        }
      } else {
        return Left(
          UnderMaintenance(generateKeyResponseModel.splashMessage ?? "Something went wrong. Contact customer support."),
        );
      }
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> setAppLaunchStatus() async {
    await appCredentialStorage.setAppLaunchStatus();
    return const Right("success");
  }
}
