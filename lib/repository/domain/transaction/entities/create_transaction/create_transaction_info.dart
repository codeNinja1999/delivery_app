import 'package:fresh_fold_delivery/repository/domain/catalog/entities/catalogs.dart';

import '../../../exchange_rate/entities/entities.dart';
import '../entities.dart';

class CreateTransactionInfo {
  final TransactionSenderInfo? senderInfo;
  final TransactionReceiverInfo? receiverInfo;
  final CalculationMode? calculationMode;
  final String? amount;
  final String? exchangeRate;
  final String? receivingAmount;
  final String? promotionalCode;
  final String? discountAmount;
  final Catalog? sourceOfIncome;
  final String? purposeOfRemittanceOther;
  final String? sourceOfIncomeOther;
  final Catalog? purposeOfRemittance;
  final String? taxAmount;

  CreateTransactionInfo({
    this.senderInfo,
    this.receiverInfo,
    this.calculationMode,
    this.amount,
    this.exchangeRate,
    this.receivingAmount,
    this.promotionalCode,
    this.discountAmount,
    this.sourceOfIncome,
    this.sourceOfIncomeOther,
    this.purposeOfRemittanceOther,
    this.purposeOfRemittance,
    this.taxAmount,
  });
}

class DetailedTransaction {
  final String? id;
  final TransactionStatus? status;
  final DetailedTransactionSenderResult? senderResult;
  final TransactionReceiverResult? receiverResult;
  final CalculationMode? calculationMode;
  final String? serviceFee;
  final String? discountFee;
  final String? totalAmountToPay;
  final String? currentRate;
  final String? referenceNumber;
  final String? receiptTS;
  final String? lastUpdateTS;
  final String? customerDeposited;
  final String? taxAmount;
  final String? receiptImage;
  final String? depositType;
  final String? depositTypeName;

  DetailedTransaction({
    this.id,
    this.status,
    this.senderResult,
    this.receiverResult,
    this.calculationMode,
    this.serviceFee,
    this.discountFee,
    this.totalAmountToPay,
    this.currentRate,
    this.referenceNumber,
    this.receiptTS,
    this.lastUpdateTS,
    this.customerDeposited,
    this.taxAmount,
    this.receiptImage,
    this.depositType,
    this.depositTypeName,
  });
}

class TransactionStatusDetail {
  final String? createdDate;
  final String? approvalDate;
  final String? receivedDate;
  final String? progressDate;
  final String? paidDate;
  final String? cancelledDate;
  final String? refundedDate;

  TransactionStatusDetail({
    this.createdDate,
    this.approvalDate,
    this.receivedDate,
    this.progressDate,
    this.paidDate,
    this.cancelledDate,
    this.refundedDate,
  });
}
