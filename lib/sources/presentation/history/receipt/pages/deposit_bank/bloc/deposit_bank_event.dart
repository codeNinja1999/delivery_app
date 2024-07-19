part of 'deposit_bank_bloc.dart';

abstract class DepositBankEvent {}

class GetDepositType extends DepositBankEvent {}

class DepositTypeChanged extends DepositBankEvent {
  final DepositBank? depositBank;
  DepositTypeChanged(this.depositBank);
}
class ValidateDepositType extends DepositBankEvent {
  final DepositBank? depositBank;
  ValidateDepositType(this.depositBank);
}
