import 'dart:convert';
import 'dart:io';

import 'package:fresh_fold_delivery/repository/data/user/models/verification/upload_document_response_mode.dart';
import 'package:fresh_fold_delivery/repository/data/user/repository/azblob_base.dart';
import 'package:fresh_fold_delivery/repository/data/user/repository/mapping/azure_key_response_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/user/repository/mapping/document_upload_request_mapping.dart';
import 'package:fresh_fold_delivery/repository/data/user/repository/mapping/upload_customer_kyc_request_mapping.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:path/path.dart' as path;

import 'package:uuid/uuid.dart';

import '../models/azure_key/azure_key_response_model.dart';

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

  @override
  Future<Either<Exception, String>> uploadCustomerKyc(UploadUserKycInfo userKycInfo) async {
    final requestData = userKycInfo.toRequestData();
    final postBody = jsonEncode(requestData.toJson());

    try {
      final _ = await networkClient.send(
        AppServiceEndpoints.uploadCustomerKyc,
        method: HttpMethod.post,
        body: postBody,
      );

      return const Right("");
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, AzureInfo>> getAzureInfo(String uploadType) async {
    try {
      final response = await appAuthenticationNetworkClient.get(AppServiceEndpoints.azureKey + uploadType);
      final responseJson = json.decode(response.asString);
      final info = AzureKeyResponseModel.fromJson(responseJson).toDomain();
      return Right(info);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<Either<Exception, String>> uploadDocument(DocumentUpload documentInfo) async {
    try {
      String containerName = documentInfo.azureInfo?.containerName ?? "";
      String customerId = documentInfo.docType?.toUpperCase() ?? "";
      String fileExtension = path.extension(documentInfo.documentImage?.path ?? "");
      String blobConnection = documentInfo.azureInfo?.blobConnection ?? "";
      final fileName = "DOC_${customerId}_DOCUMENT_${const Uuid().v4()}$fileExtension";
      final file = File(documentInfo.documentImage?.path ?? "");
      final fileBytes = await file.readAsBytes();

      var storage = AzureStorage.parse(blobConnection);
      await storage.putBlob(
        '/$containerName/$fileName',
        bodyBytes: fileBytes,
        contentType: 'image/jpeg',
        type: BlobType.blockBlob,
      );

      return Right(fileName);
    } on Exception catch (error) {
      return Left(error);
    }
  }
}
