import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'home_tab_bar_event.dart';
part 'home_tab_bar_state.dart';

class HomeTabBarBloc extends Bloc<HomeTabBarEvent, HomeTabBarState> {
  final UserUtilitiesRepository userUtilitiesRepository;

  HomeTabBarBloc({required this.userUtilitiesRepository}) : super(HomeTabBarState()) {
    on<UserInfoSubscription>(_onUserInfoSubscriptionRequested);
  }

  Future<void> _onUserInfoSubscriptionRequested(
    UserInfoSubscription event,
    Emitter<HomeTabBarState> emit,
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
}
