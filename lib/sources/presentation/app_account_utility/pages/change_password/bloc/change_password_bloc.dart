import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import 'package:fresh_fold_delivery/sources/config/config.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final PasswordRepository passwordRepository;

  ChangePasswordBloc({required this.passwordRepository}) : super(ChangePasswordState()) {
    on<OldPasswordChanged>((event, emit) => emit(state.copyWith(oldPassword: event.oldPassword)));
    on<NewPasswordChanged>((event, emit) => emit(state.copyWith(changePassword: event.newPassword)));
    on<ConfirmPasswordChanged>((event, emit) => emit(state.copyWith(confirmPassword: event.confirmPassword)));
    on<ChangedPassword>(_onChangePassword);
  }

  void _onChangePassword(
    ChangePasswordEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final changePasswordInfo = ChangePasswordInfo(
      issueType: PasswordIssueType.update,
      currentPassword: state.oldPassword.encrypted(key: AppConfig.shared.appKey),
      newPassword: state.changePassword.encrypted(key: AppConfig.shared.appKey),
    );
    final response = await passwordRepository.changePassword(changePasswordInfo);
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (right) => state.copyWith(status: Success()),
      ),
    );
  }
}
