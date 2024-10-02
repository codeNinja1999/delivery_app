import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fresh_fold_delivery/repository/domain/catalog/catalog.dart';
import 'package:fresh_fold_delivery/sources/core/app_core.dart';

part 'add_location_event.dart';
part 'add_location_state.dart';

class SubmissionSuccess extends FormStatus {}

class AddLocationBloc extends Bloc<AddLocationEvent, AddLocationState> {
  final CatalogRepository catalogRepository;
  late Location? location;
  AddLocationBloc({required this.catalogRepository}) : super(AddLocationState()) {
    on<GetLocation>(_onGetLocation);
    on<AddStateEvent>((event, emit) {
      emit(state.copyWith(state: event.state));
    });
    on<CountryChanged>((event, emit) {
      emit(state.copyWith(country: event.country));
    });
    on<NeighborhoodChanged>((event, emit) {
      emit(state.copyWith(neighborhood: event.neighborhood));
    });
    on<CityChanged>((event, emit) {
      emit(state.copyWith(city: event.city));
    });
    on<SubmitLocation>(_onSubmitLocation);
  }
  _onGetLocation(GetLocation event, Emitter<AddLocationState> emit) async {
    emit(state.copyWith(
      location: location,
      locationId: location?.id,
      city: location?.city,
      neighborhood: location?.neighborhood,
      country: location?.countryCode,
      status: Success(),
    ));
  }

  _onSubmitLocation(SubmitLocation event, Emitter<AddLocationState> emit) async {
    emit(state.copyWith(status: InProgress()));
    final response = (state.locationId != "")
        ? await catalogRepository.updateLocation(state.makeData())
        : await catalogRepository.addLocation(state.makeData());
    response.fold(
      (error) => emit(state.copyWith(status: SubmissionFailure(error))),
      (right) => emit(state.copyWith(status: SubmissionSuccess())),
    );
  }
}
