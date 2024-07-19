import 'package:encrypt/encrypt.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/entities.dart';

class AzureCredentialsDecoder {
  static AzureInfo decryptAzureInfo({required AzureInfo azureInfo, required String appKey}) {
    final key = Key.fromUtf8(appKey);
    final iv = IV.fromUtf8(appKey);

    final aesEncrypter = Encrypter(AES(key, mode: AESMode.cbc));

    String? decrypt(String? encrypted) {
      if (encrypted == null) return null;
      try {
        final encryptedData = Encrypted.from64(encrypted);
        final decrypted = aesEncrypter.decrypt(encryptedData, iv: iv);
        return decrypted;
      } catch (e) {
        print(e);
        return "";
      }
    }

    return AzureInfo(
      blobConnection: decrypt(azureInfo.blobConnection),
      containerName: decrypt(azureInfo.containerName),
      accountName: decrypt(azureInfo.accountName),
      accountKey: decrypt(azureInfo.accountKey),
    );
  }
}
