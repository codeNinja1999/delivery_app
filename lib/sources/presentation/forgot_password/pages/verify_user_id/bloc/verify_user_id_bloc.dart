import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'verify_user_id_event.dart';
part 'verify_user_id_state.dart';

class VerifyUserIdBloc extends Bloc<VerifyUserIdEvent, VerifyUserIdState> {
  final OTPRepository otpRepository;

  VerifyUserIdBloc({required this.otpRepository}) : super(VerifyUserIdState()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<VerifyLoginId>(
      (event, emit) async {
        emit(state.copyWith(status: InProgress()));
        final data = GenerateOTP(email: state.email);
        final response = await otpRepository.generateForgotPasswordOTP(data);
        response.fold(
          (error) => emit(state.copyWith(status: SubmissionFailure(error))),
          (processID) => emit(state.copyWith(status: Success())),
        );
      },
    );
  }
}
