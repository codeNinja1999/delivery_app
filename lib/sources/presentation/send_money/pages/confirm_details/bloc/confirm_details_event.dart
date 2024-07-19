part of 'confirm_details_bloc.dart';

abstract class ConfirmDetailsEvent {}

class GetCreateTransactionResult extends ConfirmDetailsEvent {
  final CreateTransactionResult? createTransactionResult;
  GetCreateTransactionResult(this.createTransactionResult);
}

class ConfirmSendMoney extends ConfirmDetailsEvent {
  final String pinCode;
  ConfirmSendMoney({required this.pinCode});
}
