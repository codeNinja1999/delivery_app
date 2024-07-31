import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'operator_event.dart';
part 'operator_state.dart';

class OperatorBloc extends Bloc<OperatorEvent, OperatorState> {
  OperatorBloc() : super(OperatorInitial()) {
    on<OperatorEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
