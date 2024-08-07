import 'package:fresh_fold_delivery/repository/repository.dart';

extension SendOtpRequestDataMapping on GenerateOTP {
  SendOtpRequestModel toRequestData() {
    return SendOtpRequestModel(
      language: "en",
    );
  }
}
