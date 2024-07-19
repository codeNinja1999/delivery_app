import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'set_pin_event.dart';
part 'set_pin_state.dart';

class SetPinBloc extends Bloc<SetPinEvent, SetPinState> {
  SetPinBloc() : super(SetPinState()) {
    on<PinChanged>((event, emit) {
      emit(state.copyWith(pin: event.pin));
    });
  }
}
