import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'send_money_event.dart';
part 'send_money_state.dart';

class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState> {
  // DetailedReceiver? receiver;
  SendMoneyBloc() : super(SendMoneyState()) {
    on<SaveCreatedTransactionResult>((event, emit) {
      emit(state.copyWith(createdTransactionResult: event.createdTransactionResult));
    });

    on<ShowAmountChanged>((event, emit) {
      emit(state.copyWith(showAmount: event.showAmount));
    });

    on<SaveCalculateTransactionResult>((event, emit) {
      emit(state.copyWith(
        calculateTransactionResult: event.calculateTransactionResult,
        promotionCode: event.promotionCode,
      ));
    });

    on<SaveConfirmTransactionResult>((event, emit) {
      emit(state.copyWith(confirmTransactionResult: event.confirmTransactionResult));
    });

    on<SaveSelectedReceiver>((event, emit) {
      final isEdit = (event.detailedReceiver != null) ? true : false;
      emit(state.copyWith(
        detailedReceiver: event.detailedReceiver,
        isSelected: isEdit,
        isReceiverResettable: event.isReceiverResettable,
      ));
    });
  }
}
