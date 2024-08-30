import 'package:fresh_fold_delivery/repository/data/user/models/user_authentication/user_authentication_response_model.dart';
import 'package:fresh_fold_delivery/repository/domain/domain.dart';

extension UserAuthenticationResponseMapping on UserAuthenticationResponseModel {
  UserAccessCredential toDomain() {
    final userAddress = UserContactInfo(
      id: user?.userAddress?.id.toString() ?? "",
      address: user?.userAddress?.location,
      createdTime: user?.userAddress?.createdAt.toString(),
      houseNumber: user?.userAddress?.houseNumber,
      locationId: user?.userAddress?.locationId,
      latitude: user?.userAddress?.latitude,
      longitude: user?.userAddress?.longitude,
    );
    return UserAccessCredential(
      accessToken: token ?? "",
      refreshToken: "",
      firstTimeLogin: false,
      lastLoginTs: "",
      userId: user?.userId,
      firstName: user?.firstName,
      middleName: user?.middleName,
      lastName: user?.lastName,
      userName: user?.userName,
      email: user?.email,
      roles: user?.roles,
      phoneCode: user?.phoneCode,
      phoneNumber: user?.phoneNumber,
      otpVerified: user?.otpVerified,
      isVerified: user?.isVerified,
      verifiedDate: user?.verifiedDate,
      userAddress: userAddress,
      isGuest: user?.isGuest,
    );
  }
}
