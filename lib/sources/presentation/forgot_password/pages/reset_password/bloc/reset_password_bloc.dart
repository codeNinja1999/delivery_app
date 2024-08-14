import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final PasswordRepository passwordRepository;
  ResetPasswordBloc({
    required this.passwordRepository,
  }) : super(ResetPasswordState()) {
    on<NewPasswordChanged>((event, emit) => emit(state.copyWith(newPassword: event.newPassword)));
    on<ConfirmPasswordChanged>((event, emit) => emit(state.copyWith(confirmPassword: event.confirmPassword)));
    on<SetPassword>(_onChangePassword);
  }

  void _onChangePassword(
    SetPassword event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final data = ResetPasswordInfo(
      otp: event.otp,
      email: event.email,
      newPassword: state.confirmPassword,
      confirmPassword: event.confirmPassword,
    );
    final response = await passwordRepository.resetPassword(data);
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (_) => state.copyWith(status: Success()),
      ),
    );
  }
}
