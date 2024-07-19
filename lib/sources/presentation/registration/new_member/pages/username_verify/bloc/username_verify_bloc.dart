import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';

part 'username_verify_event.dart';
part 'username_verify_state.dart';

class UsernameVerifyBloc extends Bloc<UsernameVerifyEvent, UsernameVerifyState> {
  final OTPRepository otpRepository;
  UsernameVerifyBloc({
    required this.otpRepository,
  }) : super(UsernameVerifyState()) {
    on<UserIdChanged>((event, emit) {
      emit(state.copyWith(userId: event.userId));
    });

    on<IsEmailType>((event, emit) {
      emit(state.copyWith(isEmail: event.isEmail, userId: ""));
    });

    on<VerifyUserID>(
      (event, emit) async {
        emit(state.copyWith(status: InProgress()));
        final mobileNo = "${""}${state.userId}";
        final mobileNumber = mobileNo.encrypted(key: AppConfig.shared.appKey);
        final isUserEmail = state.isEmail == true ? VerifyBy.email : VerifyBy.mobileNumber;

        final data = GenerateOTP(recipient: mobileNumber, issueType: OTPIssueType.register, verifyBy: isUserEmail);
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
