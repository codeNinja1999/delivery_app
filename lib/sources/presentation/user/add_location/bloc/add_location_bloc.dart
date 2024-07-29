import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_location_event.dart';
part 'add_location_state.dart';

class AddLocationBloc extends Bloc<AddLocationEvent, AddLocationState> {
  AddLocationBloc() : super(AddLocationInitial()) {
    on<AddLocationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
