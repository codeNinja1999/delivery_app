import 'dart:convert';

UploadCustomerKycResponseModel uploadCustomerKycResponseModelFromJson(String str) =>
    UploadCustomerKycResponseModel.fromJson(json.decode(str));

class UploadCustomerKycResponseModel {
  bool processResult;
  dynamic errorList;

  UploadCustomerKycResponseModel({
    required this.processResult,
    required this.errorList,
  });

  factory UploadCustomerKycResponseModel.fromJson(Map<String, dynamic> json) => UploadCustomerKycResponseModel(
        processResult: json["process_result"],
        errorList: json["error_list"],
      );
}
