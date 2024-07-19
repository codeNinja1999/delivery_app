import 'package:fresh_fold_delivery/repository/domain/receiver/entities/receiver_contact_info.dart';
import 'package:fresh_fold_delivery/repository/domain/receiver/entities/receiver_payout_info.dart';
import 'package:fresh_fold_delivery/repository/domain/receiver/entities/receiver_personal_info.dart';

class TransactionReceiverResult {
  final String? id;
  final ReceiverPersonalInfo? personalInfo;
  final ReceiverContactInfo? contactInfo;
  final DetailedReceiverPayoutInfo? payoutInfo;
  final String? realAmount;
  final String? deductedAmount;
  final String? promptPayQR;
  final String? bankaccountName;
  final String? bankaccountNumber;

  TransactionReceiverResult({
    this.id,
    this.personalInfo,
    this.contactInfo,
    this.payoutInfo,
    this.realAmount,
    this.deductedAmount,
    this.promptPayQR,
    this.bankaccountName,
    this.bankaccountNumber,
  });
}
