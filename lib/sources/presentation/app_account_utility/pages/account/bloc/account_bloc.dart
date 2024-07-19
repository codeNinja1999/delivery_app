import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final UserUtilitiesRepository userUtilitiesRepository;
  AccountBloc({required this.userUtilitiesRepository}) : super(AccountState()) {
    on<AccountInfoSubscriptionRequested>(_onAccountInfoSubscriptionRequested);
    on<LogoutUser>(_onLogoutUser);
  }

  Future<void> _onAccountInfoSubscriptionRequested(
    AccountInfoSubscriptionRequested event,
    Emitter<AccountState> emit,
  ) async {
    await emit.forEach<DetailedUser?>(
      userUtilitiesRepository.userInfo(),
      onData: (userInfo) => userInfo != null ? state.copyWith(userInfo: userInfo) : state,
      onError: (error, __) {
        final failure = error as Exception;
        return state.copyWith(status: SubmissionFailure(failure));
      },
    );
  }

  Future<void> _onLogoutUser(
    LogoutUser event,
    Emitter<AccountState> emit,
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
