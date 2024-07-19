import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import '../../login/model/login_view_model.dart';

part 'device_verification_event.dart';
part 'device_verification_state.dart';

class ResendDeviceVerifyOTPSuccess extends FormStatus {}

class DeviceVerificationBloc extends Bloc<DeviceVerificationEvent, DeviceVerificationState> {
  final UserAuthenticationRepository userAuthenticationRepository;
  final OTPRepository otpRepository;

  LoginViewModel? loginViewModel;
  late Timer _timer;

  DeviceVerificationBloc({
    required this.otpRepository,
    required this.userAuthenticationRepository,
  }) : super(DeviceVerificationState()) {
    on<VerifyDevice>(_verifyDevice);
    on<RetryLogin>(_loginUser);
    on<VerificationCodeChanged>(
      (event, emit) => emit(
        state.copyWith(code: event.code, status: InitialStatus()),
      ),
    );
    on<SecondTicked>(_onSecondTicked);
    _startTimer();
  }

  Future<void> _verifyDevice(VerifyDevice event, Emitter<DeviceVerificationState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final verificationCode = state.code?.encrypted(key: AppConfig.shared.appKey);

    final verifyInfo = VerifyOTP(
      verifyBy: VerifyBy.mobileNumber,
      issueType: OTPIssueType.newDevice,
      processID: loginViewModel?.deviceVerificationProcessId ?? "",
      verificationCode: verificationCode ?? "",
    );

    final response = await otpRepository.verifyOTP(verifyInfo);
    if (response.isRight) {
      add(RetryLogin());
    } else {
      emit(state.copyWith(status: SubmissionFailure(response.left)));
    }
  }

  Future<void> _loginUser(RetryLogin event, Emitter<DeviceVerificationState> emit) async {
    emit(state.copyWith(status: InProgress()));

    final username = loginViewModel?.username.encrypted(key: AppConfig.shared.appKey);
    final password = loginViewModel?.password.encrypted(key: AppConfig.shared.appKey);

    final userLoginCredential = UserLoginCredential(username: username ?? "", password: password ?? "");

    final loginInfo = LoginInfo(userLoginCredential: userLoginCredential, loginType: LoginType.email);

    final response = await userAuthenticationRepository.authenticateUser(loginInfo);

    response.fold(
      (error) {
        if (error is NewDeviceDetected) {
          loginViewModel = loginViewModel?.copyWith(deviceVerificationProcessId: error.toString());
          emit(state.copyWith(
            status: ResendDeviceVerifyOTPSuccess(),
            resendDuration: const Duration(minutes: 3),
          ));
          _startTimer();
        } else {
          emit(state.copyWith(status: SubmissionFailure(error)));
        }
      },
      (_) async {
        await updateUserPersistance();
        emit(state.copyWith(status: Success()));
      },
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(SecondTicked());
    });
  }

  void _onSecondTicked(SecondTicked event, Emitter<DeviceVerificationState> emit) {
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

  Future<Either<Exception, String>> updateUserPersistance() async {
    if (loginViewModel?.shouldRemember ?? false) {
      final response = await userAuthenticationRepository.getUser();
      if (response.right != loginViewModel?.username) {
        return await userAuthenticationRepository.persistUser(loginViewModel?.username ?? "");
      } else {
        return const Right("success");
      }
    } else {
      return await userAuthenticationRepository.clearPersistUser();
    }
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
