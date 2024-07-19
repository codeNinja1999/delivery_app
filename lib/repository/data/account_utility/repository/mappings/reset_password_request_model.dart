import 'package:fresh_fold_delivery/repository/data/account_utility/model/reset_password_info/reset_password_info_request_model.dart';
import 'package:fresh_fold_delivery/repository/data/user_utility/mapping/password_issue_type_mapping.dart';
import 'package:fresh_fold_delivery/repository/domain/account_utility/entities/reset_password_info.dart';

extension ResetPasswordRequestDataMapping on ResetPasswordInfo {
  ResetPasswordRequestModel toRequestData() {
    final requestData = ResetPasswordRequestModel(
      newPassword: newPassword,
      processID: processID,
      issueType: passwordIssueType.value,
    );
    return requestData;
  }
}
