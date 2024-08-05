import 'dart:convert';

import 'package:fresh_fold_delivery/repository/data/user/models/verification/upload_document_response_mode.dart';
import 'package:fresh_fold_delivery/repository/data/user/repository/mapping/document_upload_request_mapping.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

class UserVerificationRepositoryImpl implements UserVerificationRepository {
  UserVerificationRepositoryImpl({required this.networkClient, required this.appAuthenticationNetworkClient});

  NetworkClient networkClient;

  NetworkClient appAuthenticationNetworkClient;

  @override
  Future<Either<Exception, String>> uploadDocumentImage(DocumentImageUploadInfo verificationInfo) async {
    final requestData = verificationInfo.toRequestData();

    final requestFormData = await requestData.toJson().toMultipartFile();
    try {
      final response = await networkClient.send(
        AppServiceEndpoints.documentUpload,
        method: HttpMethod.post,
        body: requestFormData,
      );
      final responseJson = jsonDecode(response.asString);
      final responseData = UploadDocumentResponseModel.fromJson(responseJson);
      return Right(responseData.code ?? "");
    } on Exception catch (error) {
      return Left(error);
    }
  }


}
