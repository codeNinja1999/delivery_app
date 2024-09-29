import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import '../../../../../repository/domain/user/entities/user_info/user.dart';
import '../../../../../repository/domain/user/repository/user_utility_repository.dart';

part 'operator_dash_board_event.dart';
part 'operator_dash_board_state.dart';

class OperatorDashBoardBloc extends Bloc<OperatorDashBoardEvent, OperatorDashBoardState> {
  final UserUtilitiesRepository userUtilitiesRepository;
  OperatorDashBoardBloc({required this.userUtilitiesRepository}) : super(OperatorDashBoardState()) {
    on<GetOperatorInfo>((event, emit) async {
      await Future.wait([_onGetOperatorInfo(event, emit)]);
    });
    on<OperatorInfoSubscriptionRequested>(_onOperatorInfoSubscriptionRequested);
    on<TogglePickupOrder>(_onTogglePickupOrder);
    on<GetPickupOrder>(_onGetPickupOrder);
    on<GetDeliveryOrder>(_onGetDeliveryOrder);
  }

  _onTogglePickupOrder(TogglePickupOrder event, Emitter<OperatorDashBoardState> emit) {
    emit(state.copyWith(isPickupOrder: !state.isPickupOrder));
  }

  Future<void> _onOperatorInfoSubscriptionRequested(
    OperatorInfoSubscriptionRequested event,
    Emitter<OperatorDashBoardState> emit,
  ) async {
    await emit.forEach<DetailedUser?>(
      userUtilitiesRepository.userInfo(),
      onData: (userInfo) => userInfo != null ? state.copyWith(operatorInfo: userInfo) : state,
      onError: (error, __) {
        final failure = error as Exception;
        return state.copyWith(status: SubmissionFailure(failure));
      },
    );
  }

  Future<bool> _onGetOperatorInfo(GetOperatorInfo event, Emitter<OperatorDashBoardState> emit) async {
    await userUtilitiesRepository.getUserInfo();
    return true;
  }

  _onGetDeliveryOrder(GetDeliveryOrder event, Emitter<OperatorDashBoardState> emit) async {
    await userUtilitiesRepository.getUserInfo();
    return true;
  }

  _onGetPickupOrder(GetPickupOrder event, Emitter<OperatorDashBoardState> emit) async {
    await userUtilitiesRepository.getUserInfo();
    return true;
  }
}
