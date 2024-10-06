import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user.dart';

import '../model/update_user_info/update_user_info_request_model.dart';

extension UpdateUserProfileRequestDataMapping on User {
  UserUpdateRequestModel toUpdateUserProfile() {
    final createOrderRequestModel = UserUpdateRequestModel(
      firstName: personalInfo?.firstName,
      middleName: personalInfo?.middleName,
      lastName: personalInfo?.lastName,
      userName: personalInfo?.fullName,
      phoneCode: personalInfo?.phoneCode,
      phoneNumber: personalInfo?.phoneNumber,
      houseNumber: contactInfo?.houseNumber,
      additionalInformation: additionalInformation,
    );
    return createOrderRequestModel;
  }
}
