part of 'add_location_bloc.dart';

class AddLocationState extends Equatable {
  final String? state;
  final String? city;
  final String? country;
  final Location? location;
  final String? neighborhood;
  final FormStatus status;

  AddLocationState({this.state, this.city, this.neighborhood, this.location, this.country, status})
      : status = (status != null) ? status : InitialStatus();

  AddLocationState copyWith({
    String? state,
    String? city,
    String? neighborhood,
    String? country,
    Location? location,
    FormStatus? status,
  }) {
    return AddLocationState(
      state: state ?? this.state,
      city: city ?? this.city,
      country: country ?? this.country,
      neighborhood: neighborhood ?? this.neighborhood,
      location: location ?? this.location,
      status: status ?? InitialStatus(),
    );
  }

  CatalogFilter makeData() {
    return CatalogFilter(
      city: city,
      country: country,
      neighborhood: neighborhood,
    );
  }

  @override
  List<Object?> get props => [state, city, neighborhood, country, location, status];
}
