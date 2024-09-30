import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/repository.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import '../../../../../repository/domain/pickup_order/pickup_order_result.dart';

part 'order_history_event.dart';
part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final UserUtilitiesRepository userUtilitiesRepository;
  OrderHistoryBloc({required this.userUtilitiesRepository}) : super(OrderHistoryState()) {
    on<GetOrderHistory>(_onGetOrderHistory);
  }

  void _onGetOrderHistory(
    GetOrderHistory event,
    Emitter<OrderHistoryState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final response = await userUtilitiesRepository.getOrderHistory(PaginationFilter(
      page: event.pageNumber,
      pageSize: 10,
    ));
    response.fold((error) => emit(state.copyWith(status: SubmissionFailure(error))), (pickupOrderList) {
      final updatedList = (state.orderList != null) ? List.of(state.orderList as Iterable) : [];
      if (pickupOrderList.isNotEmpty) {
        updatedList.addAll(pickupOrderList);
      } else {
        emit(state);
      }
    });
  }
}
