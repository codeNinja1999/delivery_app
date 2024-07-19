import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

import '../../../../core/app_core.dart';
import '../../../../config/config.dart';

part 'new_member_event.dart';
part 'new_member_state.dart';

class NewMemberBloc extends Bloc<NewMemberEvent, NewMemberState> {
  NewMemberBloc() : super(const NewMemberState()) {
    on<VerificationDetailCollected>((event, emit) {
      emit(state.copyWith(
        userName: event.userName,
        verificationProcessID: event.processId,
        isEmail: event.isEmail,
      ));
    });

    on<SetUserPin>((event, emit) => emit(state.copyWith(pin: event.pin)));

    on<SaveRegisterProcessID>(
      (event, emit) => emit(state.copyWith(registerProcessID: event.processId)),
    );

    on<SaveNationality>(
      (event, emit) => emit(state.copyWith(nationality: event.nationality)),
    );

    on<SaveReferralCode>(
      (event, emit) => emit(state.copyWith(referralCode: event.referralCode)),
    );

    on<SaveUserPersonalInfo>(
      (event, emit) => emit(state.copyWith(userPersonalInfo: event.userPersonalInfo, email: event.email)),
    );
  }
}
