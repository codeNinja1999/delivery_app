import 'package:fresh_fold_delivery/repository/data/user_utility/model/update_user_info/update_user_info.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/user_info/user.dart';

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