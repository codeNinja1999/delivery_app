class UserRegistrationResponseModel {
  UserRegistrationResponseModel({
    this.processResult,
    this.memberInfo,
  });

  bool? processResult;
  MemberInfo? memberInfo;

  factory UserRegistrationResponseModel.fromJson(Map<String, dynamic> json) => UserRegistrationResponseModel(
        processResult: json["process_result"],
        memberInfo: MemberInfo.fromJson(json["member_info"]),
      );
}

class MemberInfo {
  MemberInfo({
    this.issanctioned,
  });

  String? issanctioned;

  factory MemberInfo.fromJson(Map<String, dynamic> json) => MemberInfo(
        issanctioned: json["issanctioned"],
      );
}
