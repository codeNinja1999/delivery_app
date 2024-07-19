import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../model/confirm_details_model_view.dart';

part 'confirm_details_event.dart';
part 'confirm_details_state.dart';

class ConfirmDetailsBloc extends Bloc<ConfirmDetailsEvent, ConfirmDetailsState> {
  final TransactionActivityRepository transactionActivityRepository;
  final UserUtilitiesRepository userUtilitiesRepository;

  ConfirmDetailsBloc({
    required this.transactionActivityRepository,
    required this.userUtilitiesRepository,
  }) : super(ConfirmDetailsState()) {
    on<GetCreateTransactionResult>(
      (event, emit) => emit(
        state.copyWith(
          createTransactionResult: event.createTransactionResult,
          confirmDetailsModelView: ConfirmDetailsModelView.fromSendTransaction(event.createTransactionResult),
        ),
      ),
    );
    on<ConfirmSendMoney>(_onConfirmSendMoney);
  }

  void _onConfirmSendMoney(
    ConfirmSendMoney event,
    Emitter<ConfirmDetailsState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final info = ConfirmTransactionInfo(
      transactionID: state.createTransactionResult?.id,
      tradePassword: event.pinCode,
    );
    final response = await transactionActivityRepository.confirmCreatedTransaction(info);
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (details) {
          final filter = TransactionListFilter(
            pageNumber: "1",
            itemCount: "20",
            startDate: "",
            endDate: "",
            issueType: "02",
          );
          transactionActivityRepository.getTransactionList(filter);
          userUtilitiesRepository.getUserInfo();
          return state.copyWith(confirmTransactionResult: details, status: Success());
        },
      ),
    );
  }
}
