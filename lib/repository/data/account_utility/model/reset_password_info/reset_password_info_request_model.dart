class ResetPasswordRequestModel {
  ResetPasswordRequestModel({this.newPassword, this.processID, this.issueType});

  String? newPassword;
  String? processID;
  String? issueType;

  Map<String, dynamic> toJson() => {
        "new_login_password": newPassword,
        "process_id": processID,
        "issue_type": issueType,
      };
}
