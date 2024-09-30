import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/domain/catalog/catalog.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'add_location_event.dart';
part 'add_location_state.dart';

class AddLocationBloc extends Bloc<AddLocationEvent, AddLocationState> {
  final CatalogRepository catalogRepository;
  late Location? location;
  AddLocationBloc({required this.catalogRepository}) : super(AddLocationState()) {
    on<GetLocation>((event, emit) {
      emit(state.copyWith(
        location: location,
        city: location?.city,
        neighborhood: location?.neighborhood,
        country: location?.countryCode,
      ));
    });
    on<AddStateEvent>((event, emit) {
      emit(state.copyWith(state: event.state));
    });
    on<CountryChanged>((event, emit) {
      emit(state.copyWith(country: event.country));
    });
    on<AddNeighborhoodEvent>((event, emit) {
      emit(state.copyWith(neighborhood: event.neighborhood));
    });
    on<AddCityEvent>((event, emit) {
      emit(state.copyWith(city: event.city));
    });
    on<SubmitLocation>(_onSubmitLocation);
  }
  _onSubmitLocation(SubmitLocation event, Emitter<AddLocationState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final response = await catalogRepository.addLocation(event.catalogFilter);
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (right) => emit(state.copyWith(status: Success())),
    );
  }
}
