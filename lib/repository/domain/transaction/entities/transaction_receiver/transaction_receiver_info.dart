import 'package:fresh_fold_delivery/repository/domain/receiver/entities/receiver_payout_info.dart';

class TransactionReceiverInfo {
  final String? id;
  final DetailedReceiverPayoutInfo? payoutInfo;

  TransactionReceiverInfo({this.id, this.payoutInfo});
}
