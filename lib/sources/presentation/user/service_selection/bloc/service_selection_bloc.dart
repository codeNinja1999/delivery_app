import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/domain/catalog/catalog.dart';
import 'package:fresh_fold_delivery/repository/domain/hygiene_info/hygiene_info.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'service_selection_event.dart';
part 'service_selection_state.dart';

class ServiceSelectionBloc extends Bloc<ServiceSelectionEvent, ServiceSelectionState> {
  final CatalogRepository catalogRepository;

  ServiceSelectionBloc({required this.catalogRepository}) : super(ServiceSelectionState()) {
    on<FetchServiceType>(_onFetchServiceType);
    on<ServiceTypeSelected>((event, emit) {
      if (state.totalWeight != "") {
        var updatedAmount = state.totalAmount;
        var servicePrice = event.serviceType.price ?? 0;
        var inputWeight = int.parse(state.totalWeight);
        updatedAmount = servicePrice + inputWeight;
        emit(state.copyWith(selectedServiceType: event.serviceType, totalAmount: updatedAmount));
      }
      emit(state.copyWith(selectedServiceType: event.serviceType));
    });
    on<TotalWeightChanged>((event, emit) {
      if (state.selectedServiceType != null) {
        var updatedAmount = state.totalAmount;
        var servicePrice = state.selectedServiceType?.price ?? 0;
        var inputWeight = int.parse(event.totalWeight);
        updatedAmount = servicePrice + inputWeight;
        emit(state.copyWith(totalWeight: event.totalWeight, totalAmount: updatedAmount));
      }
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
    emit(state.copyWith(status: InProgress()));
    final response = await catalogRepository.fetchServiceType();
    emit(response.fold(
      (error) => state.copyWith(status: SubmissionFailure(error)),
      (serviceTypeList) => state.copyWith(serviceTypeList: serviceTypeList, status: Success()),
    ));
  }
}
