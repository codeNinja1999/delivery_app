import '../../../exchange_rate/entities/entities.dart';
import '../transaction_receiver/transaction_receiver.dart';
import '../transaction_sender/transaction_sender.dart';

class CalculateTransactionResult {
  final TransactionSenderResult? senderResult;
  final TransactionReceiverResult? receiverResult;
  final CalculationMode? calculationMode;
  final String? serviceFee;
  final String? discountFee;
  final String? totalAmountToPay;
  final String? currentRate;
  final String? balance;
  final String? taxAmount;

  CalculateTransactionResult({
    this.senderResult,
    this.receiverResult,
    this.calculationMode,
    this.serviceFee,
    this.discountFee,
    this.totalAmountToPay,
    this.currentRate,
    this.balance,
    this.taxAmount,
  });
}
