part of 'location_bloc.dart';

abstract class LocationEvent {}

class FetchLocation extends LocationEvent {}

class ValidateLocation extends LocationEvent {}

class LocationSelection extends LocationEvent {
  final Location selectedLocation;
  LocationSelection(this.selectedLocation);
}
