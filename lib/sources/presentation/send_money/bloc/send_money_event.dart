part of 'send_money_bloc.dart';

abstract class SendMoneyEvent {}

class SaveCreatedTransactionResult extends SendMoneyEvent {
  final CreateTransactionResult? createdTransactionResult;
  SaveCreatedTransactionResult({this.createdTransactionResult});
}

class SaveSelectedReceiver extends SendMoneyEvent {
  final DetailedReceiver? detailedReceiver;
  final bool? isReceiverResettable;
  SaveSelectedReceiver({
    this.detailedReceiver,
    this.isReceiverResettable,
  });
}

class SaveCalculateTransactionResult extends SendMoneyEvent {
  final CalculateTransactionResult? calculateTransactionResult;
  final String promotionCode;
  SaveCalculateTransactionResult({
    required this.calculateTransactionResult,
    required this.promotionCode,
  });
}

class ShowAmountChanged extends SendMoneyEvent {
  final bool showAmount;
  ShowAmountChanged(this.showAmount);
}

class SaveConfirmTransactionResult extends SendMoneyEvent {
  final ConfirmTransactionResult? confirmTransactionResult;
  SaveConfirmTransactionResult(this.confirmTransactionResult);
}
