import 'package:fresh_fold_delivery/repository/data/account_utility/model/reset_password_info/reset_password_request_model.dart';
import 'package:fresh_fold_delivery/repository/domain/account_utility/entities/reset_password_info.dart';

extension ResetPasswordRequestDataMapping on ResetPasswordInfo {
  ResetPasswordRequestModel toRequestData() {
    return ResetPasswordRequestModel(
      otp: otp,
      email: email,
      password: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
