// ignore_for_file: non_constant_identifier_names

part of 'payout_info_bloc.dart';

abstract class PayoutInfoEvent {}

class SaveBankInfo extends PayoutInfoEvent {}

class GetPayoutInfo extends PayoutInfoEvent {
  GetPayoutInfo(this.detailedReceiver, this.isEdit);
  final DetailedReceiver? detailedReceiver;
  final bool isEdit;
}

class BankSelected extends PayoutInfoEvent {
  BankSelected({required this.bank, this.receivingCountryCode});
  final Bank bank;
  final String? receivingCountryCode;
}

class BranchSelected extends PayoutInfoEvent {
  BranchSelected(this.branch);
  final Branch branch;
}

class BankBranchNameChanged extends PayoutInfoEvent {
  BankBranchNameChanged(this.bankBranchCode);
  final String bankBranchCode;
}

class BankBranchCodeChanged extends PayoutInfoEvent {
  BankBranchCodeChanged(this.bankBranchCode);
  final String bankBranchCode;
}

class AccountNumberChanged extends PayoutInfoEvent {
  AccountNumberChanged(this.accountNumber);
  final String accountNumber;
}

class GetBank extends PayoutInfoEvent {
  final PaymentMode? paymentMode;
  final String? receivingCountry;
  GetBank(this.receivingCountry, this.paymentMode);
}

class GetBranch extends PayoutInfoEvent {
  final String? bank;
  final String? receivingCountryCode;
  GetBranch(this.receivingCountryCode, this.bank);
}

class SetBankInfo extends PayoutInfoEvent {
  final DetailedReceiver? receiver;
  SetBankInfo({required this.receiver});
}
