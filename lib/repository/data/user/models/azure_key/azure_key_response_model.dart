class AzureKeyResponseModel {
  final bool? processResult;
  final StorageSettings? storageSettings;
  final List<dynamic>? warningList;
  final List<dynamic>? errorList;

  AzureKeyResponseModel({
    this.processResult,
    this.storageSettings,
    this.warningList,
    this.errorList,
  });

  factory AzureKeyResponseModel.fromJson(Map<String, dynamic> json) => AzureKeyResponseModel(
        processResult: json["process_result"],
        storageSettings: json["storageSettings"] == null ? null : StorageSettings.fromJson(json["storageSettings"]),
        warningList: json["warning_list"] == null ? [] : List<dynamic>.from(json["warning_list"]!.map((x) => x)),
        errorList: json["error_list"] == null ? [] : List<dynamic>.from(json["error_list"]!.map((x) => x)),
      );
}

class StorageSettings {
  final String? blobConnectionString;
  final String? containerName;
  final String? accountName;
  final String? accountKey;
  final int? sharedAccessExpiryTime;

  StorageSettings({
    this.blobConnectionString,
    this.containerName,
    this.accountName,
    this.accountKey,
    this.sharedAccessExpiryTime,
  });

  factory StorageSettings.fromJson(Map<String, dynamic> json) => StorageSettings(
        blobConnectionString: json["blobConnectionString"],
        containerName: json["containerName"],
        accountName: json["accountName"],
        accountKey: json["accountKey"],
        sharedAccessExpiryTime: json["sharedAccessExpiryTime"],
      );
}
