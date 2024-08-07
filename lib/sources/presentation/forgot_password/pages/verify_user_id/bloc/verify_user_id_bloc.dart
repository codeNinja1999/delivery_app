import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'verify_user_id_event.dart';
part 'verify_user_id_state.dart';

class VerifyUserIdBloc extends Bloc<VerifyUserIdEvent, VerifyUserIdState> {
  final OTPRepository otpRepository;

  VerifyUserIdBloc({required this.otpRepository}) : super(VerifyUserIdState()) {
    on<UserIdChanged>((event, emit) {
      emit(state.copyWith(userId: event.userId));
    });

    on<IsEmailType>((event, emit) {
      emit(state.copyWith(isEmail: event.isEmail, userId: ""));
    });

    on<VerifyLoginId>(
      (event, emit) async {
        emit(state.copyWith(status: InProgress()));
        final mobileNo = "${""}${state.userId}";
        final data = GenerateOTP(
          userId: mobileNo,
        );
        final response = await otpRepository.generateOTP(data);
        emit(
          response.fold(
            (error) => state.copyWith(status: SubmissionFailure(error)),
            (processID) => state.copyWith(status: Success(), processID: processID),
          ),
        );
      },
    );
  }
}
