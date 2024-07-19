import 'package:fresh_fold_delivery/repository/data/existing_member/model/check_existing_member/check_existing_member.dart';

import '../../../../../domain/domain.dart';

extension CheckExistingMemberResponseInfoMapping on CheckExistingMemberResponseModel {
  CheckExistingMemberResult toDomain() {
    return CheckExistingMemberResult(
      name: memberInfo?.senderName,
      customerId: memberInfo?.customerId,
      customerProcessId: memberInfo?.customerProcessId,
      senderAddress: memberInfo?.senderAddress,
      status: status,
    );
  }
}
