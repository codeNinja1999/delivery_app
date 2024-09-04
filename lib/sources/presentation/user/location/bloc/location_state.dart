part of 'location_bloc.dart';

class LocationState extends Equatable {
  final Location? selectedLocation;
  final List<Location> locationList;
  final FormStatus status;

  String? get locationValidation => (selectedLocation != null) ? null : LocaleKeys.locationErrorMessage.value;

  LocationState({
    this.selectedLocation,
    this.locationList = const [],
    status,
  }) : status = (status != null) ? status : InitialStatus();

  LocationState copyWith({
    Location? selectedLocation,
    List<Location>? locationList,
    FormStatus? status,
  }) {
    return LocationState(
      selectedLocation: selectedLocation ?? this.selectedLocation,
      locationList: locationList ?? this.locationList,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [selectedLocation, locationList, status];
}
