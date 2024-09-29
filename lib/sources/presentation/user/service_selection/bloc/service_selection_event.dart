part of 'service_selection_bloc.dart';

abstract class ServiceSelectionEvent {}

class FetchServiceType extends ServiceSelectionEvent {}

class ValidateService extends ServiceSelectionEvent {}

class ServiceTypeSelected extends ServiceSelectionEvent {
  final ServiceType serviceType;
  ServiceTypeSelected(this.serviceType);
}

class TotalWeightChanged extends ServiceSelectionEvent {
  final String totalWeight;
  TotalWeightChanged(this.totalWeight);
}

class IsContainBlood extends ServiceSelectionEvent {}

class IsContainPetHair extends ServiceSelectionEvent {}

class IsContainBioHazard extends ServiceSelectionEvent {}
