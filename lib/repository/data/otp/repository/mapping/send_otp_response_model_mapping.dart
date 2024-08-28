import 'package:fresh_fold_delivery/repository/domain/user/entities/authentication/user_access_credential.dart';

import '../../model/send_otp/send_otp_response_model.dart';

extension SendOtpResponseMapping on SendOtpResponseModel {
  UserAccessCredential toDomain() {
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
      userAddress: user?.userAddress,
      isGuest: user?.isGuest,
    );
  }
}
