import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'add_user_location_event.dart';
part 'add_user_location_state.dart';

class AddUserLocationBloc extends Bloc<AddUserLocationEvent, AddUserLocationState> {
  AddUserLocationBloc() : super(AddUserLocationState()) {
    on<AddUserLocationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
