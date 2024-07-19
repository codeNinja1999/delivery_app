import 'package:fresh_fold_delivery/repository/domain/otp/entities/otp_access_credential.dart';

class VerifyOtpResponseModel extends OTPAccessCredential {
  VerifyOtpResponseModel({required super.processID});

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      VerifyOtpResponseModel(processID: json["process_id"]);
}
