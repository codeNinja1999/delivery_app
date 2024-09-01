part of 'location_bloc.dart';

class LocationState extends Equatable {
  final Location? location;
  final List<Location> locationList;
  final FormStatus status;

  String? get locationValidation => (location != null) ? null : LocaleKeys.locationErrorMessage.value;

  LocationState({
    this.location,
    this.locationList = const [],
    status,
  }) : status = (status != null) ? status : InitialStatus();

  LocationState copyWith({
    Location? location,
    List<Location>? locationList,
    FormStatus? status,
  }) {
    return LocationState(
      location: location ?? this.location,
      locationList: locationList ?? this.locationList,
      status: status ?? InitialStatus(),
    );
  }

  @override
  List<Object?> get props => [location, locationList, status];
}
