import 'package:easy_localization/easy_localization.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

class TransactionListViewModel {
  final String? transactionName;
  final String? amount;
  final String? date;
  final TransactionStatus? transactionStatus;
  final String? statusImageName;
  final String? transactionId;
  final String? beneficiaryName;
  final PaymentMode? paymentMode;
  final String? depositType;
  final String? depositTypeName;
  final RemittanceMenuItemType? itemType;

  TransactionListViewModel({
    this.transactionName,
    this.amount,
    this.date,
    this.transactionStatus,
    this.statusImageName,
    this.beneficiaryName,
    this.paymentMode,
    this.depositType,
    this.transactionId,
    this.depositTypeName,
    this.itemType,
  });

  factory TransactionListViewModel.fromTransaction(DetailedTransaction data) {
    final transactionName = data.receiverResult?.personalInfo?.fullName ?? "";
    final amount = "¥ ${data.senderResult?.realAmount ?? ""}";
    final paymentMode = data.receiverResult?.payoutInfo?.mode?.id ?? "";

    return TransactionListViewModel(
      transactionName: transactionName,
      amount: amount,
      date: DateFormat('MMMM d, y h:mm a')
          .format(DateTime.parse(data.receiptTS ?? ""))
          .replaceFirstMapped(RegExp(r'am|pm'), (match) => match.group(0)!.toUpperCase()),
      statusImageName: data.status?.value ?? "",
      beneficiaryName: data.receiverResult?.personalInfo?.fullName ?? "",
      transactionId: data.id,
      transactionStatus: data.status,
      depositType: data.depositType ?? "",
      depositTypeName: data.depositTypeName ?? "",
      paymentMode: PaymentMode(id: paymentMode, value: paymentMode),
    );
  }
}

enum RemittanceMenuItemType { heading, list }
