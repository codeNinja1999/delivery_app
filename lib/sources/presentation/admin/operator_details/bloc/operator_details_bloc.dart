import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'operator_details_event.dart';
part 'operator_details_state.dart';

class OperatorDetailsBloc extends Bloc<OperatorDetailsEvent, OperatorDetailsState> {
  OperatorDetailsBloc() : super(OperatorDetailsInitial()) {
    on<OperatorDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
