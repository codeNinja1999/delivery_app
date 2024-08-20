import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'operator_list_event.dart';
part 'operator_list_state.dart';

class OperatorListBloc extends Bloc<OperatorListEvent, OperatorListState> {
  OperatorListBloc() : super(OperatorListInitial()) {
    on<OperatorListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
