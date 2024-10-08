import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/domain/domain.dart';
import 'package:fresh_fold_delivery/repository/domain/pickup_order/pickup_order_result.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'operator_history_event.dart';
part 'operator_history_state.dart';

class OperatorHistoryBloc extends Bloc<OperatorHistoryEvent, OperatorHistoryState> {
  final UserUtilitiesRepository userUtilitiesRepository;
  OperatorHistoryBloc({required this.userUtilitiesRepository}) : super(OperatorHistoryState()) {
    on<GetOrderHistory>(_onGetOrderHistory);
  }

  void _onGetOrderHistory(
    GetOrderHistory event,
    Emitter<OperatorHistoryState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final response = await userUtilitiesRepository.getOrderHistory(PaginationFilter(
      page: event.pageNumber,
      pageSize: 10,
    ));
    response.fold((error) => emit(state.copyWith(status: SubmissionFailure(error))), (pickupOrderList) {
      final updatedList = (state.orderList.isNotEmpty) ? List.of(state.orderList as Iterable) : [];
      if (pickupOrderList.isNotEmpty) {
        updatedList.addAll(pickupOrderList);
      } else {
        emit(state);
      }
    });
  }
}
