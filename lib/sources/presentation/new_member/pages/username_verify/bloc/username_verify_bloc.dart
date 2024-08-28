import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'username_verify_event.dart';
part 'username_verify_state.dart';

class UsernameVerifyBloc extends Bloc<UsernameVerifyEvent, UsernameVerifyState> {
  final OTPRepository otpRepository;
  UsernameVerifyBloc({
    required this.otpRepository,
  }) : super(UsernameVerifyState()) {
    on<EmailAddressChanged>((event, emit) {
      emit(state.copyWith(emailAddress: event.emailAddress));
    });

    on<VerifyEmailAddress>(
      (event, emit) async {
        emit(state.copyWith(status: InProgress()));

        final data = GenerateOTP(email: state.emailAddress, role: "user");
        final response = await otpRepository.generateRegisterOTP(data);
        emit(
          response.fold(
            (error) => state.copyWith(status: SubmissionFailure(error)),
            (processID) => state.copyWith(status: Success()),
          ),
        );
      },
    );
  }
}
