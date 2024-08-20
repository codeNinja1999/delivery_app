import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'update_operator_event.dart';
part 'update_operator_state.dart';

class UpdateOperatorBloc extends Bloc<UpdateOperatorEvent, UpdateOperatorState> {
  UpdateOperatorBloc() : super(UpdateOperatorInitial()) {
    on<UpdateOperatorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
