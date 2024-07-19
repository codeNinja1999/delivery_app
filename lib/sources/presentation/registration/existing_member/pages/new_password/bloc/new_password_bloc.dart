import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';
import 'package:fresh_fold_delivery/sources/config/config.dart';

part 'new_password_event.dart';
part 'new_password_state.dart';

class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  bool? isSkip;
  final ExistingMemberRepository existingMemberRepository;
  NewPasswordBloc({required this.existingMemberRepository}) : super(NewPasswordState()) {
    on<NewPasswordChanged>((event, emit) {
      emit(state.copyWith(newPassword: event.newPassword));
    });

    on<IsSkipChanged>((event, emit) {
      emit(state.copyWith(isSkip: isSkip));
    });

    on<ConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });

    on<UpdateExistingMember>(_onUpdateExistingMember);
  }

  _onUpdateExistingMember(UpdateExistingMember event, Emitter<NewPasswordState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final info = UpdateExistingMemberInfo(
      customerId: event.customerId,
      emailProcessId: event.emailProcessId,
      customerProcessId: event.customerProcessId,
      profileImage: event.profileImage,
      password: state.newPassword.encrypted(key: AppConfig.shared.appKey),
    );

    final response = await existingMemberRepository.updateExistingMember(info);
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (result) => emit(state.copyWith(status: Success())),
    );
  }
}
