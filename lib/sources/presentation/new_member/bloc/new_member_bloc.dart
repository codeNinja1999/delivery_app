import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/repository/repository.dart';

part 'new_member_event.dart';
part 'new_member_state.dart';

class NewMemberBloc extends Bloc<NewMemberEvent, NewMemberState> {
  NewMemberBloc() : super(const NewMemberState()) {
    on<VerificationDetailCollected>((event, emit) {
      emit(state.copyWith(emailAddress: event.emailAddress));
    });

    on<SaveNationality>(
      (event, emit) => emit(state.copyWith(nationality: event.nationality)),
    );

    on<SaveUserPersonalInfo>(
      (event, emit) => emit(state.copyWith(userPersonalInfo: event.userPersonalInfo)),
    );
  }
}
