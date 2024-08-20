import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_service_price_event.dart';
part 'add_service_price_state.dart';

class AddServicePriceBloc extends Bloc<AddServicePriceEvent, AddServicePriceState> {
  AddServicePriceBloc() : super(AddServicePriceInitial()) {
    on<AddServicePriceEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
