import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

import '../../../../../repository/domain/catalog/catalog.dart';

part 'add_service_price_event.dart';
part 'add_service_price_state.dart';

class SubmissionSuccess extends FormStatus {}

class AddServicePriceBloc extends Bloc<AddServicePriceEvent, AddServicePriceState> {
  final CatalogRepository catalogRepository;

  late ServiceType? service;

  AddServicePriceBloc({required this.catalogRepository}) : super(AddServicePriceState()) {
    on<GetServiceType>(_onGetServiceType);

    on<ServiceNameChanged>((event, emit) {
      emit(state.copyWith(serviceName: event.serviceName));
    });
    on<PriceChanged>((event, emit) {
      emit(state.copyWith(price: event.price));
    });
    on<SubmitService>(_onSubmitService);
  }

  _onGetServiceType(GetServiceType event, Emitter<AddServicePriceState> emit) async {
    emit(state.copyWith(
      serviceName: service?.value,
      price: service?.price.toString(),
      serviceId: service?.id,
      status: Success(),
    ));
  }

  _onSubmitService(SubmitService event, Emitter<AddServicePriceState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final response = (service != null)
        ? await catalogRepository.updateServiceType(state.makeData())
        : await catalogRepository.addServiceType(state.makeData());
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (right) => emit(state.copyWith(status: SubmissionSuccess())),
    );
  }
}
