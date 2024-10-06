part of 'add_location_bloc.dart';

class AddLocationState extends Equatable {
  final String state;
  final String city;
  final String country;
  final String locationId;
  final Location? location;
  final String neighborhood;
  final FormStatus status;

  String? get countryValidation => (country != "") ? null : LocaleKeys.countryErrorMessage.value;
  String? get cityValidation => (city != "") ? null : LocaleKeys.cityErrorMessage.value;
  String? get neighborhoodValidation => (neighborhood != "") ? null : LocaleKeys.neighbourhoodErrorMessage.value;

  CatalogFilter get getData => _makeData();

  AddLocationState({
    this.state = "",
    this.city = "",
    this.locationId = "",
    this.neighborhood = "",
    this.location,
    this.country = "",
    status,
  }) : status = (status != null) ? status : InitialStatus();

  AddLocationState copyWith({
    String? state,
    String? city,
    String? locationId,
    String? neighborhood,
    String? country,
    Location? location,
    FormStatus? status,
  }) {
    return AddLocationState(
      state: state ?? this.state,
      city: city ?? this.city,
      locationId: locationId ?? this.locationId,
      country: country ?? this.country,
      neighborhood: neighborhood ?? this.neighborhood,
      location: location ?? this.location,
      status: status ?? InitialStatus(),
    );
  }

  CatalogFilter _makeData() {
    return CatalogFilter(
      id: locationId,
      city: city,
      country: country,
      neighborhood: neighborhood,
    );
  }

  @override
  List<Object?> get props => [state, locationId, city, neighborhood, country, location, status];
}
