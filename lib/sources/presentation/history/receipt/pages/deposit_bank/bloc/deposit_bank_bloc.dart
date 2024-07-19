import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'deposit_bank_event.dart';
part 'deposit_bank_state.dart';

class DepositBankBloc extends Bloc<DepositBankEvent, DepositBankState> {
  CatalogRepository catalogRepository;
  DepositBankBloc({required this.catalogRepository}) : super(DepositBankState()) {
    on<DepositTypeChanged>((event, emit) {
      emit(state.copyWith(depositBank: event.depositBank));
    });

    on<GetDepositType>((event, emit) async {
      final response = await catalogRepository.fetchDepositBank(CatalogFilter(language: "en"));
      emit(
        response.fold(
          (error) => state.copyWith(status: SubmissionFailure(error)),
          (depositBankList) => state.copyWith(depositBankList: depositBankList),
        ),
      );
    });

    on<ValidateDepositType>((event, emit) {
      if (event.depositBank != null) {
        emit(state.copyWith(status: Success()));
      } else {
        emit(state.copyWith(status: SubmissionFailure(Exception("Deposit type cannot be empty"))));
      }
    });
  }
}
