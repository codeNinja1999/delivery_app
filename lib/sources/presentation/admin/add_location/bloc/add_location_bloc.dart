import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_location_event.dart';
part 'add_location_state.dart';

class AddLocationBloc extends Bloc<AddLocationEvent, AddLocationState> {
  AddLocationBloc() : super(AddLocationInitial()) {
    on<AddLocationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
