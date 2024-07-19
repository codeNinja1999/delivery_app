part of 'deposit_bank_bloc.dart';

class DepositBankState extends Equatable {
  final FormStatus status;
  final DepositBank? depositBank;
  final List<DepositBank>? depositBankList;
  DepositBankState({status, this.depositBank, this.depositBankList})
      : status = (status != null) ? status : InitialStatus();

  DepositBankState copyWith({
    FormStatus? status,
    DepositBank? depositBank,
    List<DepositBank>? depositBankList,
  }) {
    return DepositBankState(
      depositBank: depositBank ?? this.depositBank,
      depositBankList: depositBankList ?? this.depositBankList,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [depositBank, depositBankList, status];
}
