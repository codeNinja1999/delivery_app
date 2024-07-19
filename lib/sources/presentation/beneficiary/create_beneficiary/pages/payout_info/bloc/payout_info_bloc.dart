import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'payout_info_event.dart';
part 'payout_info_state.dart';

class PayoutInfoBloc extends Bloc<PayoutInfoEvent, PayoutInfoState> {
  final CatalogRepository catalogRepository;
  final ReceiverRepository receiverRepository;

  PayoutInfoBloc({required this.receiverRepository, required this.catalogRepository}) : super(PayoutInfoState()) {
    on<GetBank>(_onGetBank);
    on<SetBankInfo>(_onSetBankInfo);
    on<GetBranch>(_onGetBranchList);
    on<SaveBankInfo>(_onSaveBankInfo);
    on<BankSelected>(_onBankSelected);
    on<GetPayoutInfo>(_onGetPayoutInfo);
    on<BranchSelected>(_onBranchSelected);

    // on<branchNameChanged>((event, emit) => emit(state.copyWith(branchName: event.branchName)));
    on<BankBranchCodeChanged>((event, emit) {
      emit(state.copyWith(branchCode: event.bankBranchCode));
    });
    on<AccountNumberChanged>((event, emit) {
      emit(state.copyWith(accountNumber: event.accountNumber));
    });
  }

  void _onBankSelected(
    BankSelected event,
    Emitter<PayoutInfoState> emit,
  ) {
    emit(state.copyWith(bank: event.bank));
    add(GetBranch(event.receivingCountryCode, event.bank.id));
  }

  void _onSaveBankInfo(
    SaveBankInfo event,
    Emitter<PayoutInfoState> emit,
  ) {
    emit(state.copyWith(status: Success()));
  }

  void _onBranchSelected(
    BranchSelected event,
    Emitter<PayoutInfoState> emit,
  ) {
    emit(state.copyWith(branchName: event.branch.value, branchCode: event.branch.id));
  }

  void _onGetPayoutInfo(
    GetPayoutInfo event,
    Emitter<PayoutInfoState> emit,
  ) {
    (event.isEdit)
        ? emit(state.copyWith(
            accountNumber: event.detailedReceiver?.defaultPayoutInfo?.accountNumber,
            bank: event.detailedReceiver?.defaultPayoutInfo?.bank,
            branch: event.detailedReceiver?.defaultPayoutInfo?.branch,
            branchCode: event.detailedReceiver?.defaultPayoutInfo?.branch?.id,
            branchName: event.detailedReceiver?.defaultPayoutInfo?.branch?.value,
            isEdit: event.isEdit,
          ))
        : null;
  }

  void _onSetBankInfo(
    SetBankInfo event,
    Emitter<PayoutInfoState> emit,
  ) {
    if (event.receiver != null) {
      final receiver = event.receiver;
      emit(state.copyWith(
        beneficiaryID: receiver?.id,
        payoutMode: receiver?.defaultPayoutInfo?.mode,
        bank: receiver?.defaultPayoutInfo?.bank,
        branchCode: receiver?.defaultPayoutInfo?.branch?.id,
        branchName: receiver?.defaultPayoutInfo?.branch?.value,
        accountNumber: receiver?.defaultPayoutInfo?.accountNumber,
        isEdit: true,
      ));
      add(GetBank(
        receiver?.personalInfo?.receivingCountry?.id,
        receiver?.defaultPayoutInfo?.mode,
      ));
      add(GetBranch(
        receiver?.personalInfo?.receivingCountry?.id,
        receiver?.defaultPayoutInfo?.bank?.id,
      ));
    }
  }

  void _onGetBank(
    GetBank event,
    Emitter<PayoutInfoState> emit,
  ) async {
    final filter = CatalogFilter(
      language: 'en',
      countryCode: event.receivingCountry,
      paymentMode: event.paymentMode,
    );
    final response = await catalogRepository.fetchBankList(filter);
    emit(response.fold(
      (error) => state.copyWith(status: SubmissionFailure(error), bankList: []),
      (bankList) => state.copyWith(bankList: bankList, payoutMode: event.paymentMode),
    ));
  }

  void _onGetBranchList(
    GetBranch event,
    Emitter<PayoutInfoState> emit,
  ) async {
    final filter = CatalogFilter(
      language: 'en',
      countryCode: event.receivingCountryCode,
      bankId: event.bank,
    );
    final response = await catalogRepository.fetchBranchList(filter);
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error), branchList: []),
        (branchList) => state.copyWith(branchList: branchList),
      ),
    );
  }
}
