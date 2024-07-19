import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(const ForgotPasswordState()) {
    on<SaveResetOTPVerifyDetails>(_onSaveResetOTPVerifyDetails);

    on<SetUserPin>((event, emit) => emit(state.copyWith(resetPin: event.pin)));
    on<SaveResetProcessID>((event, emit) => emit(state.copyWith(resetProcessID: event.resetProcessID)));
  }

  _onSaveResetOTPVerifyDetails(SaveResetOTPVerifyDetails event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(
      loginId: event.loginId,
      otpVerifyProcessID: event.processId,
      isEmail: event.isEmail,
    ));
  }
}
