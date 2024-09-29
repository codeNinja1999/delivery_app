import 'package:fresh_fold_delivery/repository/domain/domain.dart';

import '../model/get_userinfo/get_userinfo_reponse_model.dart';

extension UserAuthenticationResponseMapping on GetUserInfoResponseModel {
  DetailedUser toUserInfoDomain() {
    final address = UserContactInfo(
      id: this.userAddress?.id.toString() ?? "",
      address: this.userAddress?.location,
      createdTime: this.userAddress?.createdAt.toString(),
      houseNumber: this.userAddress?.houseNumber,
      locationId: this.userAddress?.locationId,
      latitude: this.userAddress?.latitude,
      longitude: this.userAddress?.longitude,
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
