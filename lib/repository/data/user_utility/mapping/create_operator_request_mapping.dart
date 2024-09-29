import '../../../domain/user/entities/operator/operator_entities.dart';
import '../model/operator/create_operator_request_model.dart';

extension CreateOperatorRequestMapping on Operator {
  CreateOperatorRequestModel toCreateOperator() {
    return CreateOperatorRequestModel(
      fullName: fullName,
      phoneNumber: phoneNumber,
      address: address,
      emailAddress: emailAddress,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
