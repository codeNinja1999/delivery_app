part of 'add_location_bloc.dart';

abstract class AddLocationEvent {}

class GetLocation extends AddLocationEvent {}

class SubmitLocation extends AddLocationEvent {
  final CatalogFilter catalogFilter;
  SubmitLocation(this.catalogFilter);
}

class CountryChanged extends AddLocationEvent {
  final String country;
  CountryChanged(this.country);
}

class AddStateEvent extends AddLocationEvent {
  final String state;
  AddStateEvent(this.state);
}

class AddNeighborhoodEvent extends AddLocationEvent {
  final String neighborhood;
  AddNeighborhoodEvent(this.neighborhood);
}

class AddCityEvent extends AddLocationEvent {
  final String city;
  AddCityEvent(this.city);
}
