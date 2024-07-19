import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'verify_email_event.dart';
part 'verify_email_state.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  final OTPRepository otpRepository;
  VerifyEmailBloc({required this.otpRepository}) : super(VerifyEmailState()) {
    on<EmailAddressChanged>((event, emit) {
      emit(state.copyWith(emailAddress: event.emailAddress));
    });

    on<VerifyNewEmail>(
      (event, emit) async {
        emit(state.copyWith(status: InProgress()));
        final encryptedEmailAddress = state.emailAddress.encrypted(key: AppConfig.shared.appKey);
        final data = GenerateOTP(
          recipient: encryptedEmailAddress,
          issueType: OTPIssueType.register,
          verifyBy: VerifyBy.email,
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
