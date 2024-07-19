import 'package:fresh_fold_delivery/repository/data/user_utility/model/get_userinfo/get_userinfo_reponse_model.dart';

class UserupdateinfoResponseModel {
  UserupdateinfoResponseModel({
    this.memberInfo,
  });

  MemberInfo? memberInfo;

  factory UserupdateinfoResponseModel.fromJson(Map<String, dynamic> json) => UserupdateinfoResponseModel(
        memberInfo: MemberInfo.fromJson(json["member_info"]),
      );
}
