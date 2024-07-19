import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';

part 'verify_number_event.dart';
part 'verify_number_state.dart';

class VerifyNumberBloc extends Bloc<VerifyNumberEvent, VerifyNumberState> {
  final OTPRepository otpRepository;
  VerifyNumberBloc({required this.otpRepository}) : super(VerifyNumberState()) {
    on<UserIdChanged>((event, emit) {
      emit(state.copyWith(userId: event.userId));
    });

    on<VerifyUserID>(
      (event, emit) async {
        emit(state.copyWith(status: InProgress()));
        final mobileNo = "${""}${state.userId}";
        final mobileNumber = mobileNo.encrypted(key: AppConfig.shared.appKey);

        final data = GenerateOTP(recipient: mobileNumber, issueType: OTPIssueType.register, verifyBy: VerifyBy.mobileNumber);
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
