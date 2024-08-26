import 'package:fresh_fold_delivery/repository/domain/operator/entities/operator_entities.dart';

import '../../model/update_operator_request_model.dart';

extension UpdateOperatorRequestMapping on OperatorInfo {
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
