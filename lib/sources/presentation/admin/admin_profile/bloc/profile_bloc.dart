import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/domain/domain.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class AdminProfileBloc extends Bloc<AdminProfileEvent, AdminProfileState> {
  final UserUtilitiesRepository userUtilitiesRepository;

  AdminProfileBloc({required this.userUtilitiesRepository}) : super(AdminProfileState()) {
    on<LogoutUser>(_onLogoutUser);
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
