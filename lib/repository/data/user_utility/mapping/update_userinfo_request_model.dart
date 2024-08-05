import 'package:fresh_fold_delivery/repository/data/user_utility/model/update_user_info/update_user_info_request_model.dart';
import 'package:fresh_fold_delivery/repository/domain/user/entities/update/user_update_info.dart';

extension UpdateuserinfoRequestDataMapping on UserUpdateInfo {
  UserUpdateInfoRequestModel toRequestData() {
    final name = Name(
        lastName: userInfo?.personalInfo.fullName,
        firstName: userInfo?.personalInfo.fullName,
        middleName: userInfo?.personalInfo.fullName);
    final addressInfo = AddressInfo(
      masterCode: "",
      addressStreet: userInfo?.userContactInfo?.streetAddress,
      addressCity: userInfo?.userContactInfo?.city?.id,
      addressState: userInfo?.userContactInfo?.state?.id,
      addressInput: userInfo?.userContactInfo?.streetNumber,
    );
    final memberInfo = MemberInfo(
        nameAlternate: name, nameEnglish: name, addressInfo: addressInfo, gender: userInfo?.personalInfo.gender?.id);
    final requestData = UserUpdateInfoRequestModel(tradePassword: tradePassword, memberInfo: memberInfo);
    return requestData;
  }
}
