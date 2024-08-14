import 'package:fresh_fold_delivery/repository/data/user/models/registration/user_registration_request_model.dart';

import '../../../../domain/user/entities/registration/registration_info.dart';

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
