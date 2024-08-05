import 'package:fresh_fold_delivery/repository/data/user/models/registration/user_registration_request_model.dart';

import '../../../../domain/user/entities/registration/registration_info.dart';

extension UserRegistraionRequestDataMapping on RegistrationInfo {
  UserRegistrationRequestModel toRequestData() {


    final requestData = UserRegistrationRequestModel(
    );
    return requestData;
  }
}
