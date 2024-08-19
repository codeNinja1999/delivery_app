import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'price_edit_event.dart';
part 'price_edit_state.dart';

class PriceEditBloc extends Bloc<PriceEditEvent, PriceEditState> {
  PriceEditBloc() : super(PriceEditInitial()) {
    on<PriceEditEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
