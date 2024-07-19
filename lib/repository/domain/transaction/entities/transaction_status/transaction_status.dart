class TransactionStatus {
  final TransactionType type;
  final String value;

  TransactionStatus({required this.type, required this.value});
}

enum TransactionType {
  pendingPayment,
  paymentReview,
  hold,
  post,
  checking,
  paid,
  refund,
  cancelled,
  error,
  unknown,
}
