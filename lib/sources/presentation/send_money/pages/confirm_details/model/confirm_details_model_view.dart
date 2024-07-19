import 'package:fresh_fold_delivery/repository/domain/transaction/entities/create_transaction/create_transaction_result.dart';

class ConfirmDetailsModelView {
  final String? beneficiaryName;
  final String? beneficiaryCountry;
  final String? paymentMethod;
  final String? bankName;
  final String? accountNumber;
  final String? exchangeRate;
  final String? transferAmount;
  final String? receivingAmount;
  final String? serviceFee;
  final String? totalAmountToPay;

  ConfirmDetailsModelView({
    this.beneficiaryName,
    this.beneficiaryCountry,
    this.paymentMethod,
    this.bankName,
    this.accountNumber,
    this.exchangeRate,
    this.transferAmount,
    this.receivingAmount,
    this.serviceFee,
    this.totalAmountToPay,
  });

  factory ConfirmDetailsModelView.fromSendTransaction(CreateTransactionResult? transactionResult) {
    return ConfirmDetailsModelView(
      beneficiaryName: "",
      beneficiaryCountry: "",
      paymentMethod: "",
      bankName: "",
      accountNumber: "",
      exchangeRate: "",
    );
  }
}
