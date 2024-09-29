import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/domain/domain.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'operator_profile_event.dart';
part 'operator_profile_state.dart';

class OperatorProfileBloc extends Bloc<OperatorProfileEvent, OperatorProfileState> {
  final UserUtilitiesRepository userUtilitiesRepository;

  OperatorProfileBloc({required this.userUtilitiesRepository}) : super(OperatorProfileState()) {
    on<GetOperatorInfo>(_onGetOperatorInfo);

    on<OperatorInfoSubscriptionRequested>(_onOperatorInfoSubscriptionRequested);
    on<LogoutUser>(_onLogoutUser);
  }

  _onOperatorInfoSubscriptionRequested(
    OperatorInfoSubscriptionRequested event,
    Emitter<OperatorProfileState> emit,
  ) async {
    await emit.forEach<DetailedUser?>(
      userUtilitiesRepository.userInfo(),
      onData: (operatorInfo) => operatorInfo != null ? state.copyWith(operatorInfo: operatorInfo) : state,
      onError: (error, __) {
        final failure = error as Exception;
        return state.copyWith(status: SubmissionFailure(failure));
      },
    );
  }

  _onGetOperatorInfo(GetOperatorInfo event, Emitter<OperatorProfileState> emit) async {
    emit(state.copyWith(status: InProgress()));
    await userUtilitiesRepository.getUserInfo();
    emit(state.copyWith(status: InitialStatus()));
  }

  Future<void> _onLogoutUser(
    LogoutUser event,
    Emitter<OperatorProfileState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final response = await userUtilitiesRepository.logoutUser();
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (_) => state.copyWith(status: Success()),
      ),
    );
  }
}
