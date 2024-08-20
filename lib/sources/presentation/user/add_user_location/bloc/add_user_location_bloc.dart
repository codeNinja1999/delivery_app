import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_user_location_event.dart';
part 'add_user_location_state.dart';

class AddUserLocationBloc extends Bloc<AddUserLocationEvent, AddUserLocationState> {
  AddUserLocationBloc() : super(AddUserLocationInitial()) {
    on<AddUserLocationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
