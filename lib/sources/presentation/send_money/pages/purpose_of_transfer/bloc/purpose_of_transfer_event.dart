part of 'purpose_of_transfer_bloc.dart';

abstract class PurposeOfTransferEvent {}

class GetCatalog extends PurposeOfTransferEvent {
}

class GetPurposeOfRemittance extends PurposeOfTransferEvent {}

class GetSourceOfFund extends PurposeOfTransferEvent {}

class PurposeOfRemittanceSelected extends PurposeOfTransferEvent {
  PurposeOfRemittanceSelected(this.purposeOfRemittance);
  final Catalog purposeOfRemittance;
}

class DepositMethodTypeSelected extends PurposeOfTransferEvent {
  DepositMethodTypeSelected(this.depositType);
  final DepositType? depositType;
}

class SourceOfFundSelected extends PurposeOfTransferEvent {
  final Catalog sourceOfFund;
  SourceOfFundSelected(this.sourceOfFund);
}

class SourceOfFundOtherSelected extends PurposeOfTransferEvent {
  final String sourceOfFundOther;
  SourceOfFundOtherSelected(this.sourceOfFundOther);
}

class PurposeOfRemittanceOtherSelected extends PurposeOfTransferEvent {
  final String purposeOfRemittanceOther;
  PurposeOfRemittanceOtherSelected(this.purposeOfRemittanceOther);
}

class SendMoney extends PurposeOfTransferEvent {
  final Catalog? purposeOfRemittance;
  final Catalog? sourceOfFunds;
  final String? sourceOfFundsOther;
  final String? purposeOfRemittanceOther;
  final String? promotionCode;
  final Catalog? depositType;
  final CalculateTransactionResult? calculateTransactionResult;
  final DetailedReceiver? detailedReceiver;

  SendMoney({
    this.purposeOfRemittance,
    this.sourceOfFunds,
    this.sourceOfFundsOther,
    this.purposeOfRemittanceOther,
    this.detailedReceiver,
    this.depositType,
    this.calculateTransactionResult,
    this.promotionCode,
  });
}
