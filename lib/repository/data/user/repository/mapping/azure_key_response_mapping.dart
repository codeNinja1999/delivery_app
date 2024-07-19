import 'package:fresh_fold_delivery/repository/data/user/models/azure_key/azure_key_response_model.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/entities.dart';

extension AzureKeyResponseMapping on AzureKeyResponseModel {
  AzureInfo toDomain() {
    return AzureInfo(
        blobConnection: storageSettings?.blobConnectionString,
        containerName: storageSettings?.containerName,
        accountName: storageSettings?.accountName,
        accountKey: storageSettings?.accountKey);
  }
}
