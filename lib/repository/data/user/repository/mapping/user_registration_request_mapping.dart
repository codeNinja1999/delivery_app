import 'package:fresh_fold_delivery/repository/data/user/models/registration/user_registration_request_model.dart';

import '../../../../domain/user/entities/registration/operator_registration_info.dart';
import '../../../../domain/user/entities/registration/registration_info.dart';
import '../../models/registration/operator_registration_model.dart';

extension UserRegistrationRequestDataMapping on RegistrationInfo {
  UserRegistrationRequestModel toRegisterUser() {
    return UserRegistrationRequestModel(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      phoneCode: phoneCode,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}

extension OperatorRegistrationRequestDataMapping on OperatorRegistrationInfo {
  OperatorRegistrationRequestModel toRegisterOperator() {
    final userName =middleName != null ? "$firstName $middleName $lastName" : "$firstName $lastName";
    return OperatorRegistrationRequestModel(
      firstName: firstName,
      middleName: middleName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      userName:userName,
      email: email,
      locationId: locationId,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
