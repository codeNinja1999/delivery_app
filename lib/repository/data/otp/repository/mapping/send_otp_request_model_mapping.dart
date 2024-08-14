import 'package:fresh_fold_delivery/repository/repository.dart';

import '../../model/forgot_password_send_otp/forgot_password_send_otp_request_model.dart';
import '../../model/resend_otp/resend_otp_request_model.dart';
import '../../model/send_otp/send_otp_request_model.dart';

extension SendOtpRequestDataMapping on GenerateOTP {
  SendOtpRequestModel toRegisterRequestData() {
    return SendOtpRequestModel(email: email, role: role);
  }
}

extension ForgotPasswordSendOtpRequestDataMapping on GenerateOTP {
  ForgotPasswordOtpRequestModel toForgotPasswordGenerateOtp() {
    return ForgotPasswordOtpRequestModel(email: email);
  }
}

extension ResendOtpRequestDataMapping on GenerateOTP {
  ResendOtpRequestModel toResendOtp() {
    return ResendOtpRequestModel(email: email, type: type);
  }
}
