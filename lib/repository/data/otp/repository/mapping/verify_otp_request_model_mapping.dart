import 'package:fresh_fold_delivery/repository/repository.dart';

import '../../model/forgot_password_verify_otp/forgot_password_verify_otp_request_model.dart';
import '../../model/verify_otp copy/verify_otp_request_model.dart';

extension VerifyOtpDataMapping on VerifyOTP {
  VerifyOtpRequestModel toRegisterRequestData() {
    return VerifyOtpRequestModel(otp: verificationCode);
  }
}

extension ForgotPasswordVerifyOtpDataMapping on VerifyOTP {
  ForgotPasswordVerifyOtpRequestModel toForgotPasswordVerifyOtp() {
    return ForgotPasswordVerifyOtpRequestModel(email: email, otp: verificationCode);
  }
}
