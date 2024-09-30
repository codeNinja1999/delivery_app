import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import '../../../../../repository/domain/catalog/catalog.dart';

part 'add_service_price_event.dart';
part 'add_service_price_state.dart';

class AddServicePriceBloc extends Bloc<AddServicePriceEvent, AddServicePriceState> {
  final CatalogRepository catalogRepository;
  AddServicePriceBloc({required this.catalogRepository}) : super(AddServicePriceState()) {
    on<ServiceTypeChanged>((event, emit) {
      emit(state.copyWith(serviceType: event.serviceType));
    });
    on<PriceChanged>((event, emit) {
      emit(state.copyWith(price: event.price));
    });
    on<SubmitService>(_onSubmitService);
  }
   _onSubmitService(SubmitService event, Emitter<AddServicePriceState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final response = await catalogRepository.addServiceType(event.catalogFilter);
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (right) => emit(state.copyWith(status: Success())),
    );
  }
}
