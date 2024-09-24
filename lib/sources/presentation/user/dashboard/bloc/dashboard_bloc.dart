import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final UserUtilitiesRepository userUtilitiesRepository;
  final CatalogRepository catalogRepository;

  DashboardBloc({
    required this.userUtilitiesRepository,
    required this.catalogRepository,
  }) : super(DashboardState()) {
    on<GetDashboardData>((event, emit) async {
      await Future.wait([_onGetUserInfo(event, emit)]);
    });
    on<UserInfoSubscriptionRequested>(_onUserInfoSubscriptionRequested);
  }
  Future<void> _onUserInfoSubscriptionRequested(
    UserInfoSubscriptionRequested event,
    Emitter<DashboardState> emit,
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

  Future<bool> _onGetUserInfo(GetDashboardData event, Emitter<DashboardState> emit) async {
    await userUtilitiesRepository.getUserInfo();
    return true;
  }
}
