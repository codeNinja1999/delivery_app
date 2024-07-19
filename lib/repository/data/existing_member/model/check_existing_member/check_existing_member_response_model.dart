class CheckExistingMemberResponseModel {
  final bool? processResult;
  final String? status;
  final CheckExistingMemberResponseInfo? memberInfo;
  final List<dynamic>? warningList;
  final List<dynamic>? errorList;

  CheckExistingMemberResponseModel({
    this.processResult,
    this.status,
    this.memberInfo,
    this.warningList,
    this.errorList,
  });

  factory CheckExistingMemberResponseModel.fromJson(Map<String, dynamic> json) => CheckExistingMemberResponseModel(
        processResult: json["process_result"],
        status: json["status"],
        memberInfo: json["member_info"] == null ? null : CheckExistingMemberResponseInfo.fromJson(json["member_info"]),
        warningList: json["warning_list"] == null ? [] : List<dynamic>.from(json["warning_list"]!.map((x) => x)),
        errorList: json["error_list"] == null ? [] : List<dynamic>.from(json["error_list"]!.map((x) => x)),
      );
}

class CheckExistingMemberResponseInfo {
  final String? senderName;
  final String? customerProcessId;
  final String? senderAddress;
  final String? customerId;
  final NameAlternate? nameAlternate;

  CheckExistingMemberResponseInfo({
    this.senderName,
    this.customerProcessId,
    this.senderAddress,
    this.customerId,
    this.nameAlternate,
  });

  factory CheckExistingMemberResponseInfo.fromJson(Map<String, dynamic> json) => CheckExistingMemberResponseInfo(
        senderName: json["sender_name"],
        customerProcessId: json["customer_process_id"],
        senderAddress: json["sender_address"],
        customerId: json["customer_id"],
        nameAlternate: json["name_alternate"] == null ? null : NameAlternate.fromJson(json["name_alternate"]),
      );
}

class NameAlternate {
  NameAlternate();

  factory NameAlternate.fromJson(Map<String, dynamic> json) => NameAlternate();
}
