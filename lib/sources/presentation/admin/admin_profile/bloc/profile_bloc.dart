import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/domain/domain.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class AdminProfileBloc extends Bloc<AdminProfileEvent, AdminProfileState> {
  final UserUtilitiesRepository userUtilitiesRepository;

  AdminProfileBloc({required this.userUtilitiesRepository}) : super(AdminProfileState()) {
    on<GetAdminInfo>(_onGetAdminInfo);

    on<AdminInfoSubscriptionRequested>(_onAdminInfoSubscriptionRequested);
    on<LogoutUser>(_onLogoutUser);
  }

  _onAdminInfoSubscriptionRequested(
    AdminInfoSubscriptionRequested event,
    Emitter<AdminProfileState> emit,
  ) async {
    await emit.forEach<DetailedUser?>(
      userUtilitiesRepository.userInfo(),
      onData: (adminInfo) => adminInfo != null ? state.copyWith(adminInfo: adminInfo) : state,
      onError: (error, __) {
        final failure = error as Exception;
        return state.copyWith(status: SubmissionFailure(failure));
      },
    );
  }

  _onGetAdminInfo(GetAdminInfo event, Emitter<AdminProfileState> emit) async {
    emit(state.copyWith(status: InProgress()));
    await userUtilitiesRepository.getUserInfo();
    emit(state.copyWith(status: InitialStatus()));
  }

  Future<void> _onLogoutUser(
    LogoutUser event,
    Emitter<AdminProfileState> emit,
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
