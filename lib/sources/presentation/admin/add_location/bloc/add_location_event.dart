part of 'add_location_bloc.dart';

abstract class AddLocationEvent {}

class GetLocation extends AddLocationEvent {}

class SubmitLocation extends AddLocationEvent {}

class CountryChanged extends AddLocationEvent {
  final String country;
  CountryChanged(this.country);
}

class AddStateEvent extends AddLocationEvent {
  final String state;
  AddStateEvent(this.state);
}

class NeighborhoodChanged extends AddLocationEvent {
  final String neighborhood;
  NeighborhoodChanged(this.neighborhood);
}

class CityChanged extends AddLocationEvent {
  final String city;
  CityChanged(this.city);
}
