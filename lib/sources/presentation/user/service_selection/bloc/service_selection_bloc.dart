import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'service_selection_event.dart';
part 'service_selection_state.dart';

class ServiceSelectionBloc extends Bloc<ServiceSelectionEvent, ServiceSelectionState> {
  ServiceSelectionBloc() : super(ServiceSelectionInitial()) {
    on<ServiceSelectionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
