import '../../../../../domain/domain.dart';
import '../../../model/model.dart';

extension UpdateExistingMemberRequestMapping on UpdateExistingMemberInfo {
  UpdateExistingMemberRequestModel toRequest() {
    return UpdateExistingMemberRequestModel(
      customerId: customerId,
      customerPassword: password,
      customerProfileImage: profileImage,
      customerPin: pin,
      customerProcessId: customerProcessId,
      emailProcessId: emailProcessId,
    );
  }
}
