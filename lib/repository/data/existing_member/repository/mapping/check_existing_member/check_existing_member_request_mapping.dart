import 'package:fresh_fold_delivery/repository/data/existing_member/model/check_existing_member/check_existing_member_request_model.dart';

import '../../../../../domain/domain.dart';

extension CheckExistingMemberRequestMapping on CheckExistingMemberInfo {
  CheckExistingMemberRequestModel toRequest() {
    return CheckExistingMemberRequestModel(
      idType: idType,
      idNumber: idNumber,
      dateOfBirth: dateOfBirth,
      transactionId: transactionId,
      transactionDate: transactionDate,
      transactionAmount: transactionAmount,
      otpProcessId: otpProcessId,
    );
  }
}
