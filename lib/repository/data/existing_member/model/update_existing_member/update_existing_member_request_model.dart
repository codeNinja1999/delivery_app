class UpdateExistingMemberRequestModel {
  final String? customerProcessId;
  final String? emailProcessId;
  final String? customerId;
  final String? customerProfileImage;
  final String? customerPassword;
  final String? customerPin;

  UpdateExistingMemberRequestModel({
    this.customerProcessId,
    this.emailProcessId,
    this.customerId,
    this.customerProfileImage,
    this.customerPassword,
    this.customerPin,
  });

  Map<String, dynamic> toJson() => {
        "customer_process_id": customerProcessId,
        "customer_id": customerId,
        "customer_profile_image": customerProfileImage,
        "customer_pin_no": customerPin,
        "customer_password": customerPassword,
        "email_process_id": emailProcessId,
      };
}
