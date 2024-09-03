import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/domain/pickup_order/pickup_order.dart';
import 'package:fresh_fold_delivery/repository/domain/user/repository/user_utility_repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final UserUtilitiesRepository userUtilitiesRepository;

  CheckoutBloc({required this.userUtilitiesRepository}) : super(CheckoutState()) {
    on<CreateOrder>(_onCreateOrder);
  }

  Future<void> _onCreateOrder(CreateOrder event, Emitter<CheckoutState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final response = await userUtilitiesRepository.createOrder(event.pickupOrder);
    emit(response.fold(
      (error) => state.copyWith(status: SubmissionFailure(error)),
      (serviceTypeList) => state.copyWith(status: Success()),
    ));
  }
}
