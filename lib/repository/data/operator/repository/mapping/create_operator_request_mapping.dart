import 'package:fresh_fold_delivery/repository/domain/operator/entities/operator_entities.dart';

import '../../model/create_operator_request_model.dart';

extension CreateOperatorRequestMapping on OperatorInfo {
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
