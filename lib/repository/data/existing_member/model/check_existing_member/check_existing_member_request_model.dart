class CheckExistingMemberRequestModel {
  final String? idType;
  final String? idNumber;
  final String? dateOfBirth;
  final String? transactionId;
  final String? transactionDate;
  final String? transactionAmount;
  final String? otpProcessId;

  CheckExistingMemberRequestModel({
    this.idType,
    this.idNumber,
    this.dateOfBirth,
    this.transactionId,
    this.transactionDate,
    this.transactionAmount,
    this.otpProcessId,
  });

  Map<String, dynamic> toJson() => {
        "id_type": idType,
        "id_number": idNumber,
        "date_of_birth": dateOfBirth,
        "transaction_id": transactionId,
        "transaciton_date": transactionDate,
        "transaction_amount": transactionAmount,
        "otp_process_id": otpProcessId,
      };
}
