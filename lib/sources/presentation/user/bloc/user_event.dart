part of 'user_bloc.dart';

abstract class UserEvent {}

class SaveLocation extends UserEvent {
  final Location? location;
  SaveLocation(this.location);
}

class SaveServiceType extends UserEvent {
  final String totalWeight;
  final ServiceType? serviceType;
  SaveServiceType(this.serviceType, this.totalWeight);
}

class SavePickupDate extends UserEvent {
  final DateTime? pickupDate;
  SavePickupDate(this.pickupDate);
}

class SaveHygieneParameter extends UserEvent {
  final HygieneInfo hygieneInfo;
  SaveHygieneParameter(this.hygieneInfo);
}
