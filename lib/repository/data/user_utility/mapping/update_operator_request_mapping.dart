import '../../../domain/user/entities/operator/operator_entities.dart';
import '../model/operator/update_operator_request_model.dart';

extension UpdateOperatorRequestMapping on Operator {
  UpdateOperatorRequestModel toUpdateOperator() {
    return UpdateOperatorRequestModel(
      fullName: fullName,
      phoneNumber: phoneNumber,
      address: address,
      emailAddress: emailAddress,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
