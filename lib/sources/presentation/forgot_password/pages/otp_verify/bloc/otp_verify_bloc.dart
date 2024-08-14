import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'otp_verify_event.dart';
part 'otp_verify_state.dart';

class ResendResetOTPSuccess extends FormStatus {}

class OtpVerifyBloc extends Bloc<OtpVerifyEvent, OtpVerifyState> {
  final OTPRepository otpRepository;
  late Timer _timer;

  OtpVerifyBloc({required this.otpRepository}) : super(OtpVerifyState()) {
    on<OtpCodeChanged>((event, emit) async {
      emit(state.copyWith(verificationCode: event.verificationCode, status: InitialStatus()));
    });
    on<ResendOtp>(_onResendOtp);
    on<SecondTicked>(_onSecondTicked);
    on<VerifyResetOTP>((event, emit) async {
      emit(state.copyWith(status: InProgress()));
      final verifyInfo = VerifyOTP(email: event.email, verificationCode: event.verificationCode);
      final response = await otpRepository.verifyForgotPasswordOTP(verifyInfo);
      emit(
        response.fold(
          (error) => state.copyWith(status: SubmissionFailure(error)),
          (processId) => state.copyWith(status: Success()),
        ),
      );
    });
    _startTimer();
  }

  void _onResendOtp(
    ResendOtp event,
    Emitter<OtpVerifyState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final data = GenerateOTP(email: event.email, type: "forgot_password");
    final response = await otpRepository.resendOTP(data);
    response.fold((error) => emit(state.copyWith(status: SubmissionFailure(error))), (processID) {
      emit(state.copyWith(
        status: ResendResetOTPSuccess(),
        resendDuration: const Duration(minutes: 3),
      ));
      _startTimer();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(SecondTicked());
    });
  }

  void _onSecondTicked(SecondTicked event, Emitter<OtpVerifyState> emit) {
    if ((state.status is! InProgress)) {
      emit(state.copyWith(status: InitialStatus()));
    }
    final seconds = (state.resendDuration.inSeconds) - 1;
    if (seconds < 0) {
      emit(state.copyWith(resendDuration: Duration(seconds: seconds)));
      _timer.cancel();
    } else {
      emit(state.copyWith(resendDuration: Duration(seconds: seconds)));
    }
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
