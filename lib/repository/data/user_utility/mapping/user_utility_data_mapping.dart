import 'package:fresh_fold_delivery/repository/domain/domain.dart';

import '../model/get_userinfo/get_userinfo_reponse_model.dart';

extension UserAuthenticationResponseMapping on GetUserInfoResponseModel {
  DetailedUser toUserInfoDomain() {
    final address = UserContactInfo(
      id: userAddress?.id.toString() ?? "",
      address: userAddress?.location,
      createdTime: userAddress?.createdAt.toString(),
      houseNumber: userAddress?.houseNumber,
      locationId: userAddress?.locationId,
      latitude: userAddress?.latitude,
      longitude: userAddress?.longitude,
      mobileNumber: phoneNumber,
      emailAddress: email,
    );

    return DetailedUser(
      id: userId.toString(),
      personalInfo: UserPersonalInfo(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        email: email,
        fullName: '$firstName ${middleName?.isNotEmpty == true ? '$middleName ' : ''}$lastName',
        phoneCode: phoneCode,
        phoneNumber: phoneNumber,
      ),
      contactInfo: address,
    );
  }
}
