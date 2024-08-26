import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'update_operator_event.dart';
part 'update_operator_state.dart';

class UpdateOperatorBloc extends Bloc<UpdateOperatorEvent, UpdateOperatorState> {
  UpdateOperatorBloc() : super(UpdateOperatorState()) {
    on<UpdateOperator>(_onUpdateOperator);
  }

  _onUpdateOperator(UpdateOperator event, Emitter<UpdateOperatorState> emit) async {
    emit(state.copyWith(status: InProgress()));
    // final response = await userRegistrationRepository.register(event.userRegistrationInfo);
    // response.fold(
    //   (error) => emit(state.copyWith(status: SubmissionFailure(error))),
    //   (right) => emit(state.copyWith(status: RegisteredSuccess())),
    // );
  }
}
