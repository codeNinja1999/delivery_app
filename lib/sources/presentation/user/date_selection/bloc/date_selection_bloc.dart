import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'date_selection_event.dart';
part 'date_selection_state.dart';

class DateSelectionBloc extends Bloc<DateSelectionEvent, DateSelectionState> {
  DateSelectionBloc() : super(DateSelectionInitial()) {
    on<DateSelectionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
