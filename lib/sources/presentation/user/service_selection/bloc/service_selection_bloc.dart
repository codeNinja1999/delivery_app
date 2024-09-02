import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/domain/catalog/catalog.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'service_selection_event.dart';
part 'service_selection_state.dart';

class ServiceSelectionBloc extends Bloc<ServiceSelectionEvent, ServiceSelectionState> {
  final CatalogRepository catalogRepository;

  ServiceSelectionBloc({required this.catalogRepository}) : super(ServiceSelectionState()) {
    on<FetchServiceType>(_onFetchServiceType);
    on<ServiceTypeSelected>((event, emit) {
      emit(state.copyWith(serviceType: event.serviceType));
    });
    on<TotalWeightChanged>((event, emit) {
      emit(state.copyWith(totalWeight: event.totalWeight));
    });
    on<IsContainBioHazard>((event, emit) {
      emit(state.copyWith(noBiohazard: !state.noBiohazard));
    });
    on<IsContainBlood>((event, emit) {
      emit(state.copyWith(noBlood: !state.noBlood));
    });
    on<IsContainPetHair>((event, emit) {
      emit(state.copyWith(noPetHair: !state.noPetHair));
    });
  }
  Future<void> _onFetchServiceType(
    FetchServiceType event,
    Emitter<ServiceSelectionState> emit,
  ) async {
    final response = await catalogRepository.fetchServiceType();
    emit(response.fold(
      (error) => state.copyWith(status: SubmissionFailure(error)),
      (serviceTypeList) => state.copyWith(serviceTypeList: serviceTypeList, status: Success()),
    ));
  }
}
