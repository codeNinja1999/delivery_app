import 'package:fresh_fold_delivery/repository/domain/transaction/entities/transaction_status/transaction_status.dart';

extension TransactionStatusMapping on TransactionStatus {
  static TransactionStatus fromString({
    required String code,
    required String value,
  }) {
    switch (code.toLowerCase()) {
      case "8":
        return TransactionStatus(type: TransactionType.pendingPayment, value: value);
      case "9":
        return TransactionStatus(type: TransactionType.paymentReview, value: value);
      case "1":
        return TransactionStatus(type: TransactionType.hold, value: value);
      case "2":
        return TransactionStatus(type: TransactionType.post, value: value);
      case "3":
        return TransactionStatus(type: TransactionType.checking, value: value);
      case "5":
        return TransactionStatus(type: TransactionType.paid, value: value);
      case "4":
        return TransactionStatus(type: TransactionType.cancelled, value: value);
      case "6":
        return TransactionStatus(type: TransactionType.refund, value: value);
      case "7":
        return TransactionStatus(type: TransactionType.error, value: value);
      default:
        return TransactionStatus(type: TransactionType.unknown, value: value);
    }
  }
}
