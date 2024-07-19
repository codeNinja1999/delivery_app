import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verification_instruction_event.dart';
part 'verification_instruction_state.dart';

class VerificationInstructionBloc
    extends Bloc<VerificationInstructionEvent, VerificationInstructionState> {
  VerificationInstructionBloc() : super(const VerificationInstructionState()) {
    on<VerificationInstructionEvent>((event, emit) {});
  }
}
