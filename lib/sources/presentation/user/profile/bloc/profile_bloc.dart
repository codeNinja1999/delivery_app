import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/domain/domain.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserUtilitiesRepository userUtilitiesRepository;

  ProfileBloc({required this.userUtilitiesRepository}) : super(ProfileState()) {
    on<GetUserData>((event, emit) async {
      await Future.wait([_onGetUserInfo(event, emit)]);
    });
    on<UserInfoSubscriptionRequested>(_onUserInfoSubscriptionRequested);
    on<LogoutUser>(_onLogoutUser);

  }

   Future<void> _onUserInfoSubscriptionRequested(
    UserInfoSubscriptionRequested event,
    Emitter<ProfileState> emit,
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

  Future<bool> _onGetUserInfo(GetUserData event, Emitter<ProfileState> emit) async {
    await userUtilitiesRepository.getUserInfo();
    return true;
  }
  Future<void> _onLogoutUser(
    LogoutUser event,
    Emitter<ProfileState> emit,
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
