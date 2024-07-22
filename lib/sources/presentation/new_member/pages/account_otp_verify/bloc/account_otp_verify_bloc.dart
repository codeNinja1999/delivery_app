import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/config/config.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

part 'account_otp_verify_event.dart';
part 'account_otp_verify_state.dart';

class ResendRegisterOTPSuccess extends FormStatus {}

class AccountOtpVerifyBloc extends Bloc<AccountOtpVerifyEvent, AccountOtpVerifyState> {
  final OTPRepository otpRepository;
  late Timer _timer;

  AccountOtpVerifyBloc({required this.otpRepository}) : super(AccountOtpVerifyState()) {
    on<ResendOtp>(_onResendOtp);
    on<SecondTicked>(_onSecondTicked);
    on<VerifyNewAccountOTP>(_onVerifyOTP);
    _startTimer();
  }

  void _onVerifyOTP(
    VerifyNewAccountOTP event,
    Emitter<AccountOtpVerifyState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));

    final verificationCode = event.verificationCode.encrypted(key: AppConfig.shared.appKey);
    final verifyInfo = VerifyOTP(
      verifyBy: event.verifyBy,
      issueType: OTPIssueType.register,
      processID: event.processID,
      verificationCode: verificationCode,
    );

    final response = await otpRepository.verifyOTP(verifyInfo);
    emit(
      response.fold(
        (error) => state.copyWith(status: SubmissionFailure(error)),
        (verifiedCredential) => state.copyWith(
          processID: verifiedCredential.processID,
          status: Success(),
        ),
      ),
    );
  }

  void _onResendOtp(
    ResendOtp event,
    Emitter<AccountOtpVerifyState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));

    final mobileNo = event.recipient;
    final userName = mobileNo.encrypted(key: AppConfig.shared.appKey);
    final data = GenerateOTP(
      recipient: userName,
      issueType: OTPIssueType.register,
      verifyBy: (event.isEmail) ? VerifyBy.email : VerifyBy.mobileNumber,
    );

    final response = await otpRepository.generateOTP(data);
    response.fold((error) => emit(state.copyWith(status: SubmissionFailure(error))), (processID) {
      emit(state.copyWith(
        status: ResendRegisterOTPSuccess(),
        processID: processID,
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

  void _onSecondTicked(SecondTicked event, Emitter<AccountOtpVerifyState> emit) {
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
