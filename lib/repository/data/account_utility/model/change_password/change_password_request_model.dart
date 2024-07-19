class ChangePasswordRequestModel {
  ChangePasswordRequestModel({
    this.currentLoginPassword,
    this.newLoginPassword,
    this.issueType,
    this.processId,
  });

  final String? currentLoginPassword;
  final String? newLoginPassword;
  final String? issueType;
  final String? processId;

  Map<String, dynamic> toJson() => {
        "current_login_password": currentLoginPassword,
        "new_login_password": newLoginPassword,
        "issue_type": issueType,
        "process_id": processId,
      };
}
