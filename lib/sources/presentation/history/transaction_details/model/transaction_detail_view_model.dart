import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

class TransactionDetailViewModel {
  final TransactionStatus? actualStatus;
  final String? receiverName;
  final String? bank;
  final String? branch;
  final String? address;
  final String? accountNumber;
  final String? mobileNumber;
  final String? receiveAmount;
  final String? receivingCountry;
  final String? sendAmount;
  final String? exchangeRate;
  final String? transferFee;
  final String? totalPaymentAmount;
  final String? actualTransactionID;
  final String? transactionID;
  final String? referenceNumber;
  final String? status;
  final String? promptPayQR;
  final String? bankAccountName;
  final String? bankAccountNumber;
  final String? taxAmount;
  final String? deliveryMethod;
  final String? receiptImage;
  final String? depositType;
  final String? date;

  TransactionDetailViewModel({
    this.actualStatus,
    this.receiverName,
    this.bank,
    this.branch,
    this.accountNumber,
    this.address,
    this.mobileNumber,
    this.receiveAmount,
    this.receivingCountry,
    this.sendAmount,
    this.exchangeRate,
    this.transferFee,
    this.totalPaymentAmount,
    this.actualTransactionID,
    this.transactionID,
    this.referenceNumber,
    this.status,
    this.promptPayQR,
    this.bankAccountName,
    this.bankAccountNumber,
    this.taxAmount,
    this.deliveryMethod,
    this.receiptImage,
    this.date,
    this.depositType,
  });
  String value() => "value";

  factory TransactionDetailViewModel.fromTransactionDetail({
    required DetailedTransaction data,
    required String actualTransactionID,
  }) {
    return TransactionDetailViewModel(
      actualStatus: data.status,
      status: data.status?.value ?? "",
      receiverName: "Transfer to ${data.receiverResult?.personalInfo?.fullName ?? ""}",
      bank: data.receiverResult?.payoutInfo?.bank?.value ?? "",
      branch: data.receiverResult?.payoutInfo?.branch?.value ?? "",
      address: data.receiverResult?.personalInfo?.address ?? "",
      accountNumber: data.receiverResult?.payoutInfo?.accountNumber ?? "",
      mobileNumber: data.receiverResult?.personalInfo?.mobile ?? "",
      receivingCountry: data.receiverResult?.contactInfo?.receivingCountry.value,
      receiveAmount: "${data.receiverResult?.realAmount ?? ""} ${data.receiverResult?.payoutInfo?.currency?.value ?? ""} ",
      sendAmount: "${data.senderResult?.realAmount ?? ""} ${data.senderResult?.currency?.value ?? ""}",
      exchangeRate:
          "1 ${data.senderResult?.currency?.value ?? ""} = ${data.currentRate ?? ""} ${data.receiverResult?.payoutInfo?.currency?.value ?? ""}",
      transferFee: "${data.serviceFee ?? ""} ${data.senderResult?.currency?.value ?? ""}",
      totalPaymentAmount: " ¥ ${data.totalAmountToPay ?? ""}",
      actualTransactionID: actualTransactionID,
      deliveryMethod: data.receiverResult?.payoutInfo?.mode?.value ?? "",
      transactionID: data.id ?? "",
      referenceNumber: data.referenceNumber,
      promptPayQR: data.receiverResult?.promptPayQR?.decrypted(key: AppConfig.shared.appKey),
      bankAccountName: data.receiverResult?.bankaccountName ?? "",
      bankAccountNumber: data.receiverResult?.bankaccountNumber ?? "",
      taxAmount: "${data.taxAmount ?? "0.00"} ${data.senderResult?.currency?.value ?? ""}",
      receiptImage: data.receiptImage,
      depositType: data.depositType,
      date: DateFormat('MMMM d, y h:mm a')
          .format(DateTime.parse(data.receiptTS ?? ""))
          .replaceFirstMapped(RegExp(r'am|pm'), (match) => match.group(0)!.toUpperCase()),
    );
  }
}
