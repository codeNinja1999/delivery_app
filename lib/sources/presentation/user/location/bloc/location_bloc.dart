import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/domain/catalog/catalog.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final CatalogRepository catalogRepository;

  LocationBloc({required this.catalogRepository}) : super(LocationState()) {
    on<FetchLocation>(_onFetchLocation);
    on<LocationSelection>((event, emit) {
      emit(state.copyWith(selectedLocation: event.selectedLocation));
    });
    on<ValidateLocation>(_onValidateLocation);
  }

  _onValidateLocation(
    ValidateLocation event,
    Emitter<LocationState> emit,
  ) {
    if (state.selectedLocation != null) {
      emit(state.copyWith(status: Success()));
    } else {
      emit(state.copyWith(status: SubmissionFailure(Exception("Location is not selected"))));
    }
  }

  Future<void> _onFetchLocation(
    FetchLocation event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(status: InProgress()));
    final response = await catalogRepository.fetchLocation();
    emit(response.fold(
      (error) => state.copyWith(status: SubmissionFailure(error)),
      (locationList) => state.copyWith(locationList: locationList, status: Success()),
    ));
  }
}
